class UsersController < ApplicationController

  skip_before_action :authenticate!, only: [:create]

  def create
    user = User.create(create_user_params)

    if user.save
      render json: { api_key: user.api_keys.last.authentication_token }, status: :created
    else
      # @TODO(shrugs) - better error handling here
      render json: { errors: user.errors }
    end
  end

  private

  def create_user_params
    params.require(:user).permit(User.strong_params)
  end
end
