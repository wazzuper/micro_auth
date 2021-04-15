# frozen_string_literal: true

return if !Settings.app.rpc

channel = RabbitMq.consumer_channel
queue = channel.queue('authentication', durable: true)

queue.subscribe(manual_ack: true) do |delivery_info, properties, payload|
  payload = JSON(payload)
  uuid = JwtEncoder.decode(payload['token'])['uuid']
  result = Auth::FetchUserService.call(uuid)

  if result.success?
    to_ads_payload = { user_id: result.user.id }.to_json

    queue.publish(
      to_ads_payload,
      app_id: 'auth',
      routing_key: properties.reply_to,
      correlation_id: properties.correlation_id
    )
  end
rescue JWT::DecodeError
  {}
end
