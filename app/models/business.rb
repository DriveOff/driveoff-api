# == Schema Information
#
# Table name: businesses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  logo       :string
#
# Indexes
#
#  index_businesses_on_user_id  (user_id)
#

class Business < ActiveRecord::Base
  belongs_to :user
  has_many :rewards
  
  mount_uploader :logo, LogoUploader
  
  validates :user, presence: true
  validates :name, presence: true
end
