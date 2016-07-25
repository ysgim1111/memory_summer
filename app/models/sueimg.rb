class Sueimg < ActiveRecord::Base
    mount_uploader :sueimg, PicuploaderUploader
    belongs_to :sueform    
    validates :sueimg, presence: true
    validate :sueimg_size_validation
  
    private
    
    def sueimg_size_validation
        errors[:sueimg] << "파일 용량이 3MB보다 큽니다." if sueimg.size > 3.megabytes
    end 
         
end
