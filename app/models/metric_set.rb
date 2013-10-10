class MetricSet < ActiveRecord::Base
  belongs_to :run

  scope :first_view, -> { where(ms_type: 'first_view').first }
  scope :repeat_view, -> { where(ms_type: 'repeat_view').first }
end
