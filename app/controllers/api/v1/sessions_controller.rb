class Api::V1::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, raise: false

  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Đăng nhập thành công.' },
        data: resource.as_json(only: [:id, :email, :name])
      }, status: :ok
    else
      render json: {
        status: { message: "Đăng nhập thất bại." }
      }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    render json: {
      status: 200,
      message: "Đã đăng xuất thành công."
    }, status: :ok
  end
end
