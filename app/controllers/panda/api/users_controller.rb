class Api::UsersController < Api::BaseController

  def my_cards
  end

  # put
  def change_password
    user = current_user

    if user && user.valid_password?(params[:old_password])
      user.password = params[:new_password]
      user.save!
      render json: {msg: "done"}
    else
      render json: {msg: "invalid password"}, status: 400 # 不要抛401, 因为401会导致客户端退出登录。
    end
  end
  # api for all classes
  def classes_old
    # render json: {coach:{name:"瑜伽美女",id:10}, name: "瑜伽小班", difficulty: 1, start_at: "2019/09/26 10:00", duration: 30}
    _cls = ClassSchedule.one_week
    ret = []
    _cls.each do |c|
      h = c.as_json(include:[:coach, :yoga_class])
      h[:booked]= current_user.appointments.where(class_schedule: c).count > 0
      h[:booked_users] = c.appointments.map &:user
      h[:fesible_cards] = current_user.valid_cards(c.start_at).as_json(methods: :name)
      h[:cur_week_appoints_count] = current_user.appointments.includes(:class_schedule)
                                        .where(class_schedules:{start_at: c.start_at.beginning_of_week..c.start_at.end_of_week}).count
      ret << h
    end
    render json: ret #ClassSchedule.one_week.to_json(include: [:coach, :yoga_class], methods:[:booked])
  end

  # api for all classes
  def classes
    @classes = ClassSchedule.one_week
    @user = current_user

    render "classes.json"
  end

  # 取消预约, 同时把payment记录标记为已取消
  def cancel_appointment
    @appointment = Appointment.find params[:appointment_id]

    if @appointment.user != current_user
      render json: {msg: '不能操作别人的预约', status: :failed} and return
    end

    if @appointment.class_schedule.start_at < DateTime.now
      render json: {msg: "已经开课，不能取消", status: :failed} and return
    end

    @appointment.cancel!


    render json: {msg: "取消成功", status: :success}
  end

  def class_detail
    cls = ClassSchedule.find params[:id]
    h = cls.as_json(include:[:coach, :yoga_class])
    h[:booked]= current_user.appointments.where(class_schedule: cls).count > 0
    h[:booked_users] = cls.appointments.map &:user
    h[:fesible_cards] = current_user.valid_cards(cls.start_at).as_json(methods: :name)
    h[:cur_week_appoints_count] = current_user.appointments.includes(:class_schedule)
                                      .where(class_schedules:{start_at: cls.start_at.beginning_of_week..cls.start_at.end_of_week}).count
    render json: h
  end

  def upload_avatar
    current_user.update({avatar: params[:user][:avatar]})

    current_user.reload

    my_info
  end

  def my_info
    render json: current_user, include: [cards:{ methods: :name}], methods: [:points, :avatar_url]
  end

  def my_bookings
    @class_schedules = current_user.appointments.joins(:class_schedule).order("class_schedules.start_at asc").where(class_schedules:{start_at:[10.hour.ago..7.days.after]}).map( &:class_schedule)

    ret = []
    @class_schedules.each do |c|
      h = c.as_json(include: [:yoga_class, :coach, appointments: {include: :user}])
      h[:checkin_status] = c.appointments.where(user: current_user).first.status

      ret << h
    end
    render json: ret
  end

  def my_bookings_all
    @class_schedules = current_user.appointments.joins(:class_schedule).order("class_schedules.start_at asc").map( &:class_schedule)

    ret = []
    @class_schedules.each do |c|
      h = c.as_json(include: [:yoga_class, :coach, appointments: {include: :user}])
      h[:checkin_status] = c.appointments.where(user: current_user).first.status

      ret << h
    end
    render json: ret
  end

  def create_booking
    class_schedule = ClassSchedule.find params[:schedule_id]
    card = Card.find(params[:card_id]) if params[:card_id].present?
    card =  current_user.valid_cards(class_schedule.start_at).first if not params[:card_id]
    user = current_user

    # 检查会员有效性。
    if user.valid_cards(class_schedule.start_at).count < 1
      render json: {msg: "无有效卡"}, status: 400 and return
    end

    # 检查是否超出预约次数限制
    can_book = user.can_book_class_schedule_with_card(class_schedule, card)
    if not can_book[:can_book]
      render json: can_book, status: 400 and return
    end

    # 检查是否过了预约期
    if class_schedule.expired
      render json: {msg: "已经过了预约期"}, status: 400 and return
    end

    # 检查是否超过了最大预约数
    if class_schedule.is_full
      render json: {msg: "已经约满了"}, status: 400 and return
    end

    # 检查是否已经预约过, 并且未取消
    if Appointment.where(user: user, class_schedule: class_schedule, status: [:create, :checked_in]).count > 0
      render json: Appointment.find_by( user: user, class_schedule: class_schedule) and return
    end

    # TODO: 把预约逻辑放到card里面去，card自己更加card type做不同的扣除操作
    app = Appointment.create!(user:user, class_schedule: class_schedule, comment: params[:comment], status: :created)
    # TODO: 次数卡要把number_left减一
    # 点卡要扣除相应的点数
    pay = Payment.create!(target: app, payment_method: card, status: :success)

    render json: app
  end



  # 在time所在周用card总共约了多少次课
  def bookings_count_per_week(user, time, card)

  end


  # 在time所在month用card总共约了多少次课
  def bookings_count_per_month(user, time, card)

  end


  # 在time所在year用card总共约了多少次课
  def bookings_count_per_year(user, time, card)

  end


  # 用card总共约了多少次课
  def bookings_count_total(user, card)

  end
end
