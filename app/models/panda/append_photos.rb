module Panda
  module AppendPhotos

    def delete_images auto_save=true
      self.remove_photos!

      if auto_save
        self.save
      end
    end

    def append_images photos_params, auto_save=true
      appended_images = photos_params.map do |image|
        uploader = PhotoUploader.new(self, "photos")
        uploader.store! image
        uploader
      end
      if auto_save

        retry_count = 10 # retry 10 time at max
        begin

          # 乐观锁，不需要上锁，只在写入的时候检查, https://icbd.github.io/wiki/rails/2018/11/22/lock-version.html
          self.reload
          # self.with_lock do
          p = self[:photos] || []
          p += appended_images.map{ |uploader| uploader.file.filename }
          # self.update(photos: p)
          self[:photos] = p
          self.save!
          # end
        rescue  ActiveRecord::StatementInvalid, ActiveRecord::StaleObjectError => e # 乐观锁, lock_version, https://ruby-china.org/topics/28963
          if retry_count > 0
            sleep rand(5..55)/1000 # this is NECESSARY in scalable real-world code,
            # although the amount of sleep is something you can tune.
            # Note the random sleep before the retry. This is necessary because failed serializable transactions have a non-trivial cost, so if we don't sleep, multiple processes contending for the same resource can swamp the db. In a heavily concurrent app you may need to gradually increase the sleep with each retry. The random is VERY important to avoid harmonic deadlocks -- if all the processes sleep the same amount of time they can get into a rhythm with each other, where they all are sleeping and the system is idle and then they all try for the lock at the same time and the system deadlocks causing all but one to sleep again.
            # https://stackoverflow.com/a/23693829
            #
            retry_count-=1
            retry
          else
            raise e
          end
        rescue => e
          raise e
        end

      else
        self[:photos] ||= []
        self[:photos] += appended_images.map{ |uploader| uploader.file.filename }
      end
    end

    def delete_photo photo_name
      a = self[:photos]||[]
      a.delete photo_name
      self[:photos]=a
    end
  end
end
