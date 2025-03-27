class Users::SessionsController < Devise::SessionsController
  include RackSessionFix

  private

  # Handle successful login response
  def respond_with(current_user, _opts = {})
    render json: {
      status: {
        code: 200,
        message: "Logged in successfully.",
        data: { user: UserSerializer.new(current_user) }
      }
    }, status: :ok
  end

  # Handle logout response
  def respond_to_on_destroy
    if current_user
      sign_out(current_user)
      render json: { message: "Logged out successfully" }, status: :ok
    else
      render json: { message: "Couldn't find an active session." }, status: :unauthorized
    end
  end
end
