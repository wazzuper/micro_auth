# frozen_string_literal: true

module AdsRpc
  module Api
    def send_user_id(user_id)
      payload = { user_id: user_id }.to_json
      publish(payload, type: 'send_user_id')
    end
  end
end
