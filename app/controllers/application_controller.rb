class ApplicationController < ActionController::Base
  def encode_token(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decode_token(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end

  def validate_manager_token
    header = request.headers['Authorization']
    header = header.split(' ').last if header
  end
end
