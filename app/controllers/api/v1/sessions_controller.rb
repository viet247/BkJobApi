class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, raise: false
  before_action :normalize_login_params, only: [:create]
  respond_to :json

  def create
    self.resource = warden.authenticate(auth_options)

    if resource
      sign_in(resource_name, resource)
      respond_with resource
    else
      render_failed_login
    end
  end

  private

  # Devise mặc định expect params[:user][:email] và params[:user][:password].
  # Cho phép cả format { "user": { "email", "password" } } và { "email", "password" }.
  def normalize_login_params
    return if params[:user].present?

    params[:user] = {
      email: params[:email],
      password: params[:password]
    }
  end

  def render_failed_login
    render json: {
      error: I18n.t("devise.failure.not_found_in_database", authentication_keys: "Email")
    }, status: :unauthorized
  end

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'You have successfully loged in!' },
      data: resource
    }, status: :ok
  end

  def respond_to_on_destroy
    render json: {
      status: 200,
      message: 'You have successfully loged out!'
    }, status: :ok
  end
end
