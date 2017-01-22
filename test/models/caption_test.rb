# == Schema Information
#
# Table name: captions
#
#  id          :integer          not null, primary key
#  grouping_id :integer
#  text        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class CaptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
