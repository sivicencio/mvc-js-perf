class Instance < ActiveRecord::Base
  belongs_to :app
  belongs_to :framework
  validates :url, presence: :true
end