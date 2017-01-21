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

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
