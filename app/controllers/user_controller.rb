class UserController < ApplicationController
  skip_before_action :verify_authenticity_token, raise: false
  before_action :authenticate_devise_api_token!, only: [:restrected]

  def home
    render json: {message: "home action"}, status: :unauthorized
  end

  def restrected
    devise_api_token = current_devise_api_token
    if devise_api_token
      render json: {message: "You are logged in as #{devise_api_token.resource_owner.email}"}, status: :ok
    else
      render json: {message: "You are not logged in"}, status: :unauthorized
  end
end
end
