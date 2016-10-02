# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string           not null
#  crypted_password                :string           not null
#  salt                            :string           not null
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  remember_me_token               :string
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  last_login_at                   :datetime
#  last_logout_at                  :datetime
#  last_activity_at                :datetime
#  last_login_from_ip_address      :string
#  name                            :string           not null
#  role                            :integer          default(1), not null
#  avatar                          :string
#  city                            :string
#  state                           :string
#  zip_code                        :integer
#  birthday                        :date             default(Tue, 01 Jan 1980), not null
#  gender                          :integer          default(1), not null
#  custom_gender                   :string
#  pronouns                        :integer
#
# Indexes
#
#  index_users_on_email                                (email) UNIQUE
#  index_users_on_last_logout_at_and_last_activity_at  (last_logout_at,last_activity_at)
#  index_users_on_remember_me_token                    (remember_me_token)
#  index_users_on_reset_password_token                 (reset_password_token)
#

class User < ActiveRecord::Base
  include PgSearch
  authenticates_with_sorcery!
  
  # A module that holds postal abbreviation helper methods
  extend PostalAbbreviations
  
  mount_uploader :avatar, AvatarUploader
  
  has_many :trips
  has_many :businesses
  has_many :redemptions
  
  validates :email, uniqueness: true, presence: true
  
  validates :password, length: { minimum: 8 }, if: :validate_password?
  validates :password, confirmation: true, if: :validate_password?
  validates :password_confirmation, presence: true, if: :validate_password?
  
  validates :name, presence: true
  
  validates :role, presence: true
  enum role: { user: 1, business_admin: 2, admin: 3 }
  
  validates :city, presence: true
  validates :state, presence: true
  validates :state, inclusion: { in: User.postal_abbreviations }
  
  validates :zip_code, length: { is: 5, message: "must be 5 and only 5 digits" }, unless: "zip_code.blank?"
  validates :zip_code, numericality: { only_integer: true, message: "must have only numbers; no punctuation or letters" }, unless: "zip_code.blank?"
  
  # Our gender options are at least as inclusive as Facebook
  validates :gender, presence: true
  enum gender: { male: 1, female: 2, undisclosed: 3, custom: 4 }
  validates :custom_gender, presence: true, if: "gender == 4"
  enum pronouns: { masculine: 1, feminine: 2, neutral: 3 }
  validates :pronouns, presence: true, if: "gender == 4"
  
  validates :birthday, presence: true
  
  pg_search_scope :search_by_email,
                  against: :email,
                  :using => {
                    :tsearch => {:prefix => true}
                  }
  
  # Users can friend each other
  has_and_belongs_to_many :users, join_table: :user_connections, foreign_key: :user_1_id, association_foreign_key: :user_2_id
  
  # Calculates the user's age based on their birthday
  def age
    now = Time.now.utc.to_date
    
    # Subtracts today's year from the birthday year, and then subtract 1 more
    # year if the user's birthday has not passed yet
    now.year - birthday.year - ((now.month > birthday.month || (now.month == birthday.month && now.day >= birthday.day)) ? 0 : 1)
  end
  
  # Calculates the user's points
  # TODO: Probably store this number in the database to reduce queries
  def points
    Trip.where(user: self).sum(:points)
  end
  
  # Calculates the user's points left over after claiming rewards
  # TODO: Probably store this number in the database to reduce queries
  def spendable_points
    points - (Redemption.where(user: self).includes(:reward).sum(:cost))
  end
  
  # Calculates the user's points from the past week
  # TODO: Probably store this number in the database to reduce queries
  def points_this_week
    now = Time.now.utc.to_date
    Trip.where(user: self, created_at: (now-7).beginning_of_day..now.end_of_day).sum(:points)
  end
  
  # Add the user as a business admin on a business
  def add_business(business)
    # Admins can't be businesses admins, they already have ultimate power
    return false if admin?
    
    businesses << business
    self.update(role: :merchant)
    
    businesses.include? business
  end
  
  # Alias for a user's users
  def friends
    users
  end
  
  # Adds a friend
  def add_friend(user2)
    # Don't let friends be double-friends
    return false if friends.include?(user2)
    
    # We add it twice so we can query either user and see their friends
    friends << user2
    user2.friends << self
    
    true
  end
  
  # Removes a friend
  def remove_friend(user2)
    # Skip if the users aren't friends
    return false if !friends.include?(user2)
    
    friends.delete(user2)
    user2.friends.delete(self)
    
    true
  end
  
  private

    def validate_password?
      new_record? || password.present?
    end
end
