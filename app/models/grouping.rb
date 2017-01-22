# == Schema Information
#
# Table name: groupings
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  game_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Grouping < ApplicationRecord
  belongs_to :user
  belongs_to :game

  has_many :snaps
  has_many :captions
end
