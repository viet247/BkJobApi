class ApplicationController < ActionController::API
  include Pagy::Backend
  include Pundit::Authorization
  before_action :configure_permitted_parameter, if: :devise_controller?

  rescue_from Pagy::VariableError do |e|
    render_error("Pagination parameters invalid: #{e.message}", :bad_request)
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

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
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :role ])
  end

  private

  def safe_page_params
    page = params[:page].to_i
    page > 0 ? page : 1
  rescue
    1
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    render_error("Denied access at #{policy_name}.#{exception.query}", :forbidden)
  end

  def render_not_found(exception)
    render_error("#{exception.model} not found!", :not_found)
  end
end
