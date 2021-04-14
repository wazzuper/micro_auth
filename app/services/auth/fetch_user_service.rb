# frozen_string_literal: true

module Auth
  class FetchUserService
    prepend BaseService

    param :uuid

    attr_reader :user

    def call
      if uuid.blank? || session.blank?
        return fail!(I18n.t(:forbidden, scope: 'services.errors.auth.fetch_user_service'))
      end
      @user = session.user
    end

    private

    def session
      @session ||= UserSession.find(uuid: uuid)
    rescue => e
      raise unless e.cause.kind_of?(PG::InvalidTextRepresentation)
    end
  end
end
