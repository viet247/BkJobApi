class Api::V1::PasswordsController < Devise::PasswordsController
  respond_to :json

  def create
    byebug
  end
end
