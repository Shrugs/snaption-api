class GamesController < ApplicationController

  def create
    # to create a game, first validate all of the user ids
    # then create a new game
    # then create grouping for each user to the game
    # then create the first caption and add it to the game
    # @TODO(shrugs) - use obscure user ids instead of autoincrementing
    # @TODO(shrugs) - use a `playable` polymorphic association to join snaps and captions to game

    # @TODO(shrugs) - will probably want to optimize this function later

    begin
      Game.transaction do
        game = Game.create!
        game_id = game.id
        Grouping.create!(create_game_params[:user_ids].map { |id| { user_id: id, game_id: game_id } })
      end
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message }
    end

    render json: { game: game.to_json }
  end

  private

  def create_game_params
    params.require(:game).permit(Game.strong_params)
  end
end
