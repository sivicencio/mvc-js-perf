class Instance < ActiveRecord::Base
  belongs_to :app
  belongs_to :framework
  has_many :runs, dependent: :destroy
  has_many :tests, through: :runs
  validates :url, presence: :true

  default_scope order('created_at ASC')
end