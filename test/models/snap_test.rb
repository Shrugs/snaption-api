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

require 'test_helper'

class SnapTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
