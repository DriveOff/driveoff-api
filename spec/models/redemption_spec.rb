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

require 'rails_helper'

RSpec.describe Redemption, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
