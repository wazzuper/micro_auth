# frozen_string_literal: true

Sequel.seed do
  def run
    30.times do |i|
      User.create!(email: "user_email_#{i}", password: "pass_#{i}", name: "John Smith #{i}")
    end
  end
end
