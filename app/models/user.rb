# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  display_name      :string           not null
#  profile_image_url :string           not null
#  fb_access_token   :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class User < ApplicationRecord
  has_many :api_keys
  has_many :groupings, dependent: :destroy
  has_many :games, through: :groupings

  validates_presence_of :api_keys

  before_validation :generate_api_key!, on: :create
  before_validation :populate_facebook_info, on: :create

  def generate_api_key!
    self.api_keys << ApiKey.create!
  end

  def populate_facebook_info
    self.assign_attributes(FacebookInfoFetcher.new(self.fb_access_token).user_info)
  end

  def self.strong_params
    [
      :fb_access_token
    ]
  end

  def to_hash
    {
      id: id,
      display_name: display_name,
      profile_image_url: profile_image_url
    }
  end

  def in_game_with_id(game_id)
    games.exists?(game_id)
  end
end
