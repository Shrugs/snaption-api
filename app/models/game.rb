# == Schema Information
#
# Table name: games
#
#  id                :integer          not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  workflow_state    :string           not null
#  requested_user_id :integer
#  play_type         :integer          default("0"), not null
#

class Game < ApplicationRecord
  include Workflow

  has_many :users, through: :groupings
  has_many :groupings, dependent: :destroy

  has_many :captions, dependent: :destroy
  has_many :snaps, dependent: :destroy
  has_many :snap_caption_pairs, dependent: :destroy

  belongs_to :requested_user, class_name: 'User'
  enum play_type: {
    snap: 0,
    caption: 1
  }

  after_create :on_initial_entry

  workflow do
    state :initial do
      # this is the initial, default state of all games
      # when we enter this state, we seed the game with a random caption
      # then call the request_play event
      event :request_play, transitions_to: :awaiting_play
    end

    state :awaiting_play do
      # on_enter, notify the requested user with the correct play type
      # when they reply with a play, call request_play with the next user and type
      #   or :complete to end the game, if the condition has been reached
      event :request_play, transitions_to: :awaiting_play
      event :complete, transitions_to: :completed
    end

    state :completed
  end


  # BEGIN WORKFLOW CALLBACKS

  def request_play(next_user, play_type = :snap)
    self.requested_user = next_user
    self.play_type = play_type
    self.save!

    # @TODO(shrugs) - notify requested user
    puts "@TODO - send a notification to #{next_user.display_name}"
  end

  def make_play!(user, play)
    puts "#{user.display_name} played a #{play.class.to_s}"

    # @TODO(shrugs) - move this to some sort of validator
    raise StandardError.new('Not your turn!') if user != self.requested_user
    raise StandardError.new('Wrong media type!') if play_type_for_play(play) != self.play_type.to_sym

    play.save!

    return self.complete! if self.captions.length + self.snaps.length >= 20

    self.request_play!(next_user(user), next_play_type(play))
  end

  # NOTE: this is the same format as the on_*_entry callbacks, but is technically
  # an after_create calback
  def on_initial_entry
    # @TODO(shrugs) - debug why on_initial_entry isn't firing
    self.create_seed_caption!
    self.request_play! users.first, :snap
  end

  def on_completed_entry(new_state, event, *args)
    puts 'Game over!'
    # @TODO(shrugs) - notify all users that the game has finished and invite them to heart their
    #   favorites
  end

  # END WORKFLOW CALLBACKS

  def create_seed_caption!
    text = CaptionGenerator.random_caption
    self.captions << Caption.create!(text: text)
  end

  def feed
    (captions + snaps).sort_by(&:created_at)
  end

  def self.strong_params
    {
      user_ids: []
    }
  end

  def to_hash
    {
      id: id,
      users: users.map(&:to_hash),
      feed: feed.map(&:to_hash),
      requested_user_id: requested_user_id,
      play_type: play_type
    }
  end

  private

  def next_user(previous_user)
    # @TODO(shrugs)
    # this method should return the next user for whom to ask for a play
    # soem sort of weighting mechanism should be used here
    # but for now, just linearly return the next user

    return users.first if previous_user.nil?

    i = users.find_index(previous_user)
    return users.first if i.nil?

    users[(i + 1) % users.length]
  end

  def play_type_for_play(play)
    return :snap if play.is_a? Snap
    return :caption
  end

  def next_play_type(latest_play)
    return :snap if play_type_for_play(latest_play) == :caption
    return :caption
  end
end
