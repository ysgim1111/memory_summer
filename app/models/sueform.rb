class Sueform < ActiveRecord::Base
    has_many :sueimgs, dependent: :destroy
    belongs_to :user
end
