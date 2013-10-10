class Run < ActiveRecord::Base
  belongs_to :instance
  belongs_to :test

  has_many :metric_sets
end
