class Users::RegistrationsController < Devise::RegistrationsController
  include RackSessionFix


  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end

  def respond_with(resource, _opts = {})
    if request.method == "POST" && resource.persisted?
      render json: { message: "Signed up successfully.", data: resource }, status: :ok

    elsif request.method == "DELETE"
      sign_out(resource)
      render json: { message: "Signed out successfully." }, status: :ok
    else
      render json: { status: { code: 422, message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" } }, status: :unprocessable_entity
    end
  end
end
