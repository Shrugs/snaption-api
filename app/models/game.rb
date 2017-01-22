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

  has_many :captions, dependent: :destroy
  has_many :snaps, dependent: :destroy
  has_many :snap_caption_pairs, dependent: :destroy

  before_create :create_seed_caption!

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
      feed: feed.map(&:to_hash)
    }
  end
end
