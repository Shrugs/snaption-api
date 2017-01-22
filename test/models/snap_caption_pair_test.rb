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

require 'test_helper'

class SnapCaptionPairTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
