class Test < ActiveRecord::Base
  belongs_to :app
  validates :name, presence: :true
end
