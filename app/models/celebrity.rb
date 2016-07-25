class Celebrity < ActiveRecord::Base
  has_many :receives, dependent: :destroy
end
