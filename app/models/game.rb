# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Game < ApplicationRecord

  has_many :users, through: :groupings
  has_many :groupings, dependent: :destroy

  # has_many :captions
  # has_many :snaps
  has_many :snap_caption_pairs, dependent: :destroy

  before_create :create_seed_caption!

  def create_seed_caption!
    text = CaptionGenerator.random_caption
    # @TODO(shrugs) - add the caption to this game
  end

  def self.strong_params
    {
      user_ids: []
    }
  end

  def to_json
    {
      users: users.map { |user| { id: user.id, display_name: user.display_name } }
    }
  end
end
