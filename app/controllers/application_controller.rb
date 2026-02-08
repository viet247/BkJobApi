class ApplicationController < ActionController::API
  include Pagy::Backend

  before_action :configure_permitted_parameter, if: :devise_controller?

  def render_success(data, meta = nil, message = "Success")
    render json: {
      success: true,
      message: message,
      data: data,
      meta: meta
    }, status: :ok
  end

  def render_error(message = "Error", status = :bad_request, errors = [])
    render json: {
      success: false,
      message: message,
      errors: errors
    }, status: status
  end

  protected

  def configure_permitted_parameter
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
  end
end
