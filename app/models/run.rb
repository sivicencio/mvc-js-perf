class Run < ActiveRecord::Base
  belongs_to :instance
  belongs_to :test
end
