# == Schema Information
#
# Table name: trips
#
#  id         :integer          not null, primary key
#  start_lat  :decimal(10, 6)   not null
#  start_lng  :decimal(10, 6)   not null
#  end_lat    :decimal(10, 6)   not null
#  end_lng    :decimal(10, 6)   not null
#  distance   :integer          default(0), not null
#  time       :integer          default(0), not null
#  points     :integer          default(0), not null
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_trips_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Trip, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
