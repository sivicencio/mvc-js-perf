class TestSetting < ActiveRecord::Base
  belongs_to :test

  scope :label, -> { where(name: 'label').first }
  scope :location, -> { where(name: 'location').first }
  scope :browser, -> { where(name: 'browser').first }  
end