# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :test do
    name "MyString"
    description "MyText"
    total_runs 1
    script "MyText"
    app nil
  end
end
