# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  display_name         :string           not null
#  profile_image_url    :string           not null
#  fb_access_token      :string           not null
#  authentication_token :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class User < ApplicationRecord
  validates :authentication_token, uniqueness: true

  AUTH_TOKEN_LENGTH = 30

  before_create :generate_authentication_token!

  def self.generate_authentication_token!
    begin
      self.authentication_token = SecureRandom.hex(AUTH_TOKEN_LENGTH)
    end while self.class.exists?(authentication_token: authentication_token)
  end
end
