class AuthenticationController < ApplicationController
  require 'jwt'
  require 'mongo'

  SECRET_KEY = 'avagaeminha'

  def create_token
    payload = { exp: Time.now.to_i + 15}
    token = JWT.encode(payload, SECRET_KEY, 'HS256')

    render json: token, status: :created
  end

  def validate_token
    token = request.headers['token']

    if token.blank?
      render json: { error: "Por favor forneça um token" }, status: :not_found
    else
      JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')[0]
    end
  rescue JWT::DecodeError
    render json: { error: "Ocorreu um erro com o token informado. Por favor tente novamente" }, status: :bad_request
  end
end
