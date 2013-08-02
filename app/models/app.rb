class App < ActiveRecord::Base
  has_many :tests, dependent: :destroy
  validates :name, presence: :true
end
