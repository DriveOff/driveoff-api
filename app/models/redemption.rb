# == Schema Information
#
# Table name: redemptions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  reward_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_redemptions_on_reward_id  (reward_id)
#  index_redemptions_on_user_id    (user_id)
#

class Redemption < ActiveRecord::Base
  belongs_to :user
  belongs_to :reward
  
  delegate :business, to: :reward
  
  validates :user, presence: true
  validates :reward, presence: true
  
  default_scope { order(created_at: :desc) }
end
