class Campaign < ApplicationRecord
    belongs_to :customer
    
    validate :picture_size
    
    mount_uploaders :pictures, PictureUploader
    
    
    private
     def picture_size
        if Picture.size > 5.megabytes
            errors.add(:pictures, "should not be more than 5mb")
        end
     end    
end    