class Framework < ActiveRecord::Base
  has_many :instances, dependent: :destroy
  has_many :apps, through: :instances
  
  validates :name, presence: true
end
