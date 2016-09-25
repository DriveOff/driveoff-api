# == Schema Information
#
# Table name: trips
#
#  id         :integer          not null, primary key
#  distance   :decimal(6, 1)    default(0.0), not null
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
  
  validates :distance, presence: true
  validates :time, presence: true
  validates :points, presence: true
  validates :user, presence: true
  
  # Our points algorithm is the user earns 1 point per 5 minutes they
  # were driving, rounded down
  before_create :calculate_points
  def calculate_points
    self.points = time / 5
  end
  
  # Someday we will maybe store distance in meters and we'll want to convert it
  # to miles.
  # def distance_in_miles
  #   (distance * 0.000621371).round(1)
  # end
end
