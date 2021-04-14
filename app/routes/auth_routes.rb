# frozen_string_literal: true

class AuthRoutes < Application
  helpers Auth

  post '/' do
    result = Auth::FetchUserService.call(extracted_token['uuid'])

    if result.success?
      meta = { user_id: result.user.id }

      status 200
      json meta: meta
    else
      status 403
      errors_response(result.errors)
    end
  end
end
