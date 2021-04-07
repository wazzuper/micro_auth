# frozen_string_literal: true

class UserSessionRoutes < Application
  post '/' do
    session_params = validate_with!(UserSessionParamsContract)
    result = UserSessions::CreateService.call(*session_params.to_h.values)

    if result.success?
      token = JwtEncoder.encode(uuid: result.session.uuid)
      meta = { token: token }

      status 201
      json meta: meta
    else
      status 401
      errors_response(result.session || result.errors)
    end
  end
end
