# frozen_string_literal: true

module UserSessions
  class CreateService
    prepend BaseService

    param :email
    param :password
    option :user, default: proc { User.find(email: email) }, reader: false

    attr_reader :session

    def call
      return fail_t!(:unauthorized) unless @user&.authenticate(password)

      @session = UserSession.new
      @session.valid? ? @user.add_session(@session) : fail!(@session.errors)
    end

    private

    def fail_t!(key)
      fail!(I18n.t(key, scope: 'services.errors.user_sessions.create_service'))
    end
  end
end
