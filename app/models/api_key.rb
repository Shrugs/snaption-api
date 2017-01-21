# == Schema Information
#
# Table name: api_keys
#
#  id                   :integer          not null, primary key
#  user_id              :integer
#  authentication_token :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class ApiKey < ApplicationRecord
  belongs_to :user
  validates :authentication_token, uniqueness: true

  AUTH_TOKEN_LENGTH = 30

  before_create :generate_authentication_token!

  def generate_authentication_token!
    begin
      self.authentication_token = SecureRandom.hex(AUTH_TOKEN_LENGTH)
    end while self.class.exists?(authentication_token: authentication_token)
  end
end
