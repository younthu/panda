# frozen_string_literal: true

module CrudPlugin
  def show
    result

    extras
    render :intelligence
  end

  def create
    @result = klass.create(payload)

    extras
    render :intelligence
  end

  def destroy
    klass.destroy(params[:id])

    head :no_content
  end

  def update
    @result = klass.find(params[:id])
    @result.update payload

    extras
    render :intelligence
  end

  def index
    @result = klass.all.recent.page(page).per(per)

    paginate @result

    extras
    render :intelligence
  end

  private

  def result
    @result ||= klass.find(params[:id])
  end

  def payload
    @payload ||= klass.params_permit(params)
  end
end
