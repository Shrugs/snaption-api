class HomeController < ApplicationController

  def index
    render json: {id: current_user.id, display_name: current_user.display_name}
  end
end
