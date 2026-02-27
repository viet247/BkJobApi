class Api::V1::PasswordsController < Devise::PasswordsController
  respond_to :json

  def create
    self.resource = User.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      render_success(nil, nil, 'Reset password instruction has sent')
    else
      errors = resource.errors.full_messages
      render_error('Failed Request ', :unprocessable_entity, errors)
    end
  end

  def update
    self.resource = User.reset_password_by_token(resource_params)
    if resource.errors.empty?
      render_success(nil, nil, 'Password has updated successfully')
    else
      render_error('Password update failed', :unprocessable_entity, resource.errors.full_messages)
    end
  end
end
