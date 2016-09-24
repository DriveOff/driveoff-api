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
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_trips_on_user_id  (user_id)
#

class Trip < ActiveRecord::Base
  belongs_to :user
  
  validates :start_lat, presence: true
  validates :start_lng, presence: true
  validates :end_lat, presence: true
  validates :end_lng, presence: true
  validates :distance, presence: true
  validates :time, presence: true
  validates :points, presence: true
  validates :user, presence: true
  
  # We store distance in meters. Sometimes we'll want it in miles.
  def distance_in_miles
    (distance * 0.000621371).round(2)
  end
end