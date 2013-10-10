class Test < ActiveRecord::Base
  belongs_to :app
  has_many :runs, dependent: :destroy
  has_many :instances, through: :runs
  has_many :test_settings
  
  validates :name, presence: :true
  validates :total_runs, numericality: { greater_than: 0 }

  #Virtual attribute for setting test location
  def location
  end

  def location=(location)
  end
end
