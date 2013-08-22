class Instance < ActiveRecord::Base
  belongs_to :app
  belongs_to :framework
  has_many :runs, dependent: :destroy
  has_many :tests, through: :runs
  validates :url, presence: :true
end