# == Schema Information
#
# Table name: snap_caption_pairs
#
#  id         :integer          not null, primary key
#  game_id    :integer
#  snap_id    :integer
#  caption_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SnapCaptionPair < ApplicationRecord
  belongs_to :game

  belongs_to :snap
  belongs_to :caption
end
