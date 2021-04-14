# frozen_string_literal: true

Sequel.seed do
  def run
    User.all.each { |u| u.add_session(UserSession.new) }
  end
end
