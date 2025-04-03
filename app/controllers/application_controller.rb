class ApplicationController < ActionController::API
  include Devise::Controllers::Helpers
  include ActionController::RequestForgeryProtection

  protect_from_forgery with: :null_session, if: -> { request.format.json? }
end
