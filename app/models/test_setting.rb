class TestSetting < ActiveRecord::Base
  belongs_to :test

  scope :label, -> { where(name: 'label') }
  scope :location, -> { where(name: 'location') }
  scope :browser, -> { where(name: 'browser') }  
end
