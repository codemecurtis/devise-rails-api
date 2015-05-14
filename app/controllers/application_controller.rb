class ApplicationController < ActionController::API
  include AbstractController::Translation

  before_action :authenticate_user_from_token!

  respond_to :json

  ## 
  # User Authentication
  # Authenticates the client with OAuth2 Resource Owner Password Credentials Grant
  def authenticate_user_from_token!
    auth_token = request.headers['Authorization']

    if auth_token
      authenticate_with_auth_token auth_token
    else
      authentication_error
    end
  end

  private

  def authenticate_with_auth_token auth_token 
    unless auth_token.include?(':')
      authentication_error
      return
    end

    p client_id = auth_token.split(':').first
    p client = Client.where(id: client_id).first

    if client && Devise.secure_compare(client.access_token, auth_token)
      # User can access
      sign_in client, store: false
    else
      authentication_error
    end
  end

  ## 
  # Authentication Failure
  # Renders a 401 error
  def authentication_error
    # User's token is either invalid or not in the right format
    render json: {error: t('application_controller.unauthorized')}, status: 401  # Authentication timeout
  end
end