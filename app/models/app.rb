class App < ActiveRecord::Base
  has_many :tests, dependent: :destroy
  has_many :instances, dependent: :destroy
  has_many :frameworks, through: :instances
  
  #accepts_nested_attributes_for :instances
  #accepts_nested_attributes_for :frameworks

  validates :name, presence: :true
end
