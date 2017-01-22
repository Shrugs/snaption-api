# == Schema Information
#
# Table name: snaps
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_src  :string           not null
#  user_id    :integer
#  game_id    :integer
#

class Snap < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def to_hash
    {
      type: 'snap',
      image_src: image_src,
      user_id: user_id,
      game_id: game_id,
      created_at: created_at
    }
  end
end
