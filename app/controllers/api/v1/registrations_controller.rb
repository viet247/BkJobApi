class Api::V1::RegistrationsController < Devise::RegistrationsController

  def sign_up(resource_name, resource)
  end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: 200,
        message: 'You have signed up successfully',
        data: resource.as_json(only: [:id, :email, :name, :role])
      }, status: :ok
    else
      render json: {
        status: 422,
        errors: resource.errors.full_messages,
        data: nil
      }, status: :unprocessable_entity
    end
  end  
end
