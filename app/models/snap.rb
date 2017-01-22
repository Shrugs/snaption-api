# == Schema Information
#
# Table name: snaps
#
#  id                 :integer          not null, primary key
#  grouping_id        :integer
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Snap < ApplicationRecord
  belongs_to :grouping

  has_attached_file :image, styles: {
    large: '2160x2160>',
    medium: '800x800>',
    thumbnail: '150x150>'
  }, default_url: '/images/:style/missing.png'

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
