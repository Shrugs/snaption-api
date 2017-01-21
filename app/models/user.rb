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

  validates_presence_of :api_keys

  before_create :generate_api_key!

  def generate_api_key
    self.api_keys << ApiKey.create!
  end

end
