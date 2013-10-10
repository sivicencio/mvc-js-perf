# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :metric_set do
    ms_type "MyString"
    load_time 1
    ttfb 1
    start_render 1
    fully_loaded 1
    speed_index 1
    doc_elements 1
    run nil
  end
end
