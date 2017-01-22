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

  has_many :snap_caption_pairs, dependent: :destroy
end
