# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |i| "name_#{i}" }
    sequence(:email) { |i| "name_#{i}" }
    password { 'givemeatoken' }
  end
end
