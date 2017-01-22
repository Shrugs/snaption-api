# == Schema Information
#
# Table name: captions
#
#  id         :integer          not null, primary key
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  game_id    :integer
#

class Caption < ApplicationRecord
  belongs_to :game
  belongs_to :user

  def to_hash
    {
      type: 'caption',
      text: text,
      user_id: user_id,
      game_id: game_id,
      created_at: created_at
    }
  end
end
