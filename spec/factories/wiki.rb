require 'factory_girl_rails'

FactoryGirl.define do
  factory :wiki do
    title "Wiki Title"
    body "Wiki bodies must be prerry long."
    user
  end
end