class GamesController < ApplicationController

  before_action :set_game, only: [:join, :show, :play_caption, :play_snap]

  def show
    render json: { game: @game.to_hash }
  end

  def create
    # @TODO(shrugs) - will probably want to optimize this function later
    begin
      user_ids = create_game_params[:user_ids]
      # @TODO(shrugs) - move this kind of logic into some sort of validator
      raise StandardError.new('Must have at least 2 people in the game') if user_ids.length < 2

      Game.transaction do
        game = Game.create!
        game_id = game.id
        Grouping.create!(user_ids.map { |id| { user_id: id, game_id: game_id } })

        render json: { game: game.to_hash }
      end
    rescue => e
      render json: { error: e.message }, status: :bad_request
    end
  end

  def join
    return render json: { error: 'Already Joined This Game' }, status: :bad_request if current_user.in_game_with_id(@game.id)

    @game.users << current_user
    if @game.save
      redirect_to action: :show
    else
      render json: { error: 'Bad Request' }, status: :bad_request
    end
  end

  def play_caption
    begin
      Game.transaction do
        caption = Caption.create!(caption_create_params.merge({
          user_id: current_user.id,
          game_id: @game.id
        }))
        caption.save!

        redirect_to action: :show
      end
    rescue => e
      render json: { error: e.message }, status: :bad_request
    end
  end

  def play_snap
    begin
      Game.transaction do
        snap = Snap.create!(snap_create_params.merge({
          user_id: current_user.id,
          game_id: @game.id
        }))
        snap.save!

        redirect_to action: :show
      end
    rescue => e
      render json: { error: e.message }, status: :bad_request
    end
  end

  private

  def create_game_params
    params.require(:game).permit(Game.strong_params)
  end

  def set_game
    @game ||= Game.find(params[:id])
  end

  def caption_create_params
    params.require(:caption).permit(Caption.strong_params)
  end
  def snap_create_params
    params.require(:snap).permit(Snap.strong_params)
  end
end
