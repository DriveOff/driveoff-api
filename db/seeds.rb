# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Make users
unless User.find_by_email("user@example.com")
  User.create!(
    name: "Regular User",
    email: "user@example.com",
    password: "testtest",
    role: :user,
    password_confirmation: "testtest",
    city: "Omaha",
    state: "NE",
    zip_code: "68144",
    birthday: "1985-01-01",
    gender: :male
  )
end

unless User.find_by_email("admin@example.com")
  User.create!(
    name: "Admin",
    email: "admin@example.com",
    password: "testtest",
    role: :admin,
    password_confirmation: "testtest",
    city: "Omaha",
    state: "NE",
    zip_code: "68108",
    birthday: "1989-06-07",
    gender: :female
  )
end

unless User.find_by_email("catsinhats@example.com")
  User.create!(
    name: "Cats in Hats Business Admin",
    email: "catsinhats@example.com",
    password: "testtest",
    role: :business_admin,
    password_confirmation: "testtest",
    city: "Omaha",
    state: "NE",
    zip_code: "68122",
    birthday: "1984-12-15",
    gender: :custom,
    custom_gender: "agender",
    pronouns: :neutral
  )
end

unless User.find_by_email("bestdogtoys@example.com")
  User.create!(
    name: "Best Dog Toys Business Admin",
    email: "bestdogtoys@example.com",
    password: "testtest",
    role: :business_admin,
    password_confirmation: "testtest",
    city: "Omaha",
    state: "NE",
    zip_code: "68122",
    birthday: "1979-12-15",
    gender: :undisclosed
  )
end

# Make friends
user1 = User.find_by_email("user@example.com")
user2 = User.find_by_email("admin@example.com")
user3 = User.find_by_email("catsinhats@example.com")
user4 = User.find_by_email("bestdogtoys@example.com")

unless user1.friends.count > 0
  user1.add_friend(user2)
  user1.add_friend(user3)
end

unless user2.friends.count > 1
  user2.add_friend(user4)
end

unless user3.friends.count > 1
  user3.add_friend(user4)
end

# Create a business
unless Business.find_by_name("Cats in Hats")
  Business.create!(
    user: User.find_by_email("catsinhats@example.com"),
    name: "Cats in Hats"
  )
end

unless Business.find_by_name("Best Dog Toys")
  Business.create!(
    user: User.find_by_email("bestdogtoys@example.com"),
    name: "Best Dog Toys"
  )
end

# Create rewards
business = Business.find_by_name("Cats in Hats")
unless business.rewards.count > 0
  Reward.create!(
    business: business,
    title: "Free Cat Hat",
    description: "One free cat hat at your local Cats in Hats store.",
    cost: 10
  )
end

business2 = Business.find_by_name("Best Dog Toys")
unless business2.rewards.count > 0
  Reward.create!(
    business: business2,
    title: "Free Dog Rope Toy",
    description: "One free dog rope toy at a Best Dog Toys supplies store near you!",
    cost: 8
  )
end

# Create trips and redemptions for each user
User.all.each do |user|
  unless user.trips.count > 0
    5.times do
      distance = rand(3.0..20.0)
    
      # Randomly drive between 20-60 miles per hour and create a time in minutes
      time = (distance / rand(20..60) * 60).round
    
      Trip.create!(
        user: user,
        distance: distance,
        time: time
      )
    end
  end
  
  unless user.redemptions.count > 0
    Redemption.create!(
      user: user,
      reward: Reward.all.sample
    )
  end
end
