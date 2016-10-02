# Make regular user
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

# Make admin
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

# Make business admins
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

# Sample names
# 25 male, 25 female, 10 undisclosed, 10 custom gender
male_users = ["Adam Freeman", "Allen Adams", "Clayton Horton", "Danny Jefferson", "Darren Morrison", "Elias Schmidt", "Freddie Mcdaniel", "Gerardo French", "Greg Caldwell", "Harry Jenkins", "Jack Herrera", "Jerald Roy", "Luke Watson", "Maurice Baker", "Mike Marshall", "Mitchell Moss", "Ramon Welch", "Roger Rios", "Roosevelt Boyd", "Ross Terry", "Santiago Ramos", "Steve Campbell", "Timothy Lee", "Virgil Fletcher", "Warren Silva"]
female_users = ["Amy Ramos", "Beth Saunders", "Betty Floyd", "Carolyn Luna", "Debra Malone", "Della Gordon", "Doreen Sherman", "Elvira Underwood", "Essie Fox", "Gladys Fields", "Hannah Knight", "Ida Doyle", "Irene Berry", "Juanita Webster", "Julie Jones", "Kathleen Weaver", "Kristine Baldwin", "Mercedes Osborne", "Pat Newton", "Roberta Paul", "Sandra Carson", "Sheila Pearson", "Thelma Taylor", "Traci Hall", "Tricia Hansen"]
undisclosed_users = ["Amari Grant", "Beckett Rodgers", "Caley Santos", "Ceres Roberts", "Dylan Harmon", "Jesse Dunn", "Micah Carr", "Nicky Burton", "Pat Holmes", "Ty Chapman"]
custom_gender_users = ["Blue Hale", "Blaze Stephens", "Cam Stokes", "Dru Cruz", "Jem Yates", "Luka Fox", "Mel Leonard", "Rowan Ferguson", "Sal Chase", "Taylor Schultz"]

# Sample cities (they're all trees)
cities = ["Abies", "Acer", "Aesculus", "Alder", "Alnus", "Apple", "Arborvitae", "Arbutus", "Ash", "Aspen", "Basswood", "Betula", "Birch", "Buckeye", "Buckthorn", "California", "Calocedrus", "Castanea", "Castanopsis", "Catalpa", "Cedar", "Cedrus", "Cercocarpus", "Chamaecyparis", "Cherry", "Chestnut", "Chinkapin", "Cornus", "Corylus", "Cottonwood", "Crataegus", "Cupressus", "Cypress", "Dogwood", "Douglas", "Elaeagnus", "Elm", "Filbert", "Fir", "Fraxinus", "Giant", "Gleditsia", "Hawthorn", "Hazel", "Hemlock", "Holly", "Honeylocust", "Horsechestnut", "Ilex", "Incense", "Juglans", "Juniper", "Juniperus", "Larch", "Larix", "Laurel", "Liquidambar", "Liriodendron", "Lithocarpus", "Locust", "Madrone", "Mahogany", "Maple", "Mountain", "Myrtle", "Oak", "Olive", "Oregon", "Pear", "Picea", "Pine", "Pinus", "Platanus", "Plum", "Poplar", "Populus", "Prunus", "Pseudotsuga", "Pyrus", "Quercus", "Redcedar", "Redwood", "Rhamnus", "Robinia", "Russian", "Salix", "Sequoia", "Sequoiadendron", "Sorbus", "Spruce", "Sweetgum", "Sycamore", "Tanoak", "Taxus", "Thuja", "Tilia", "True", "Tsuga", "Ulmus", "Umbellularia", "Walnut", "White", "Willow", "Yellow", "Yew"]

# All the states
states = User.postal_abbreviations

# Create sample users
{1 => male_users, 2 => female_users, 3 => undisclosed_users, 4 => custom_gender_users}.each do |gender, user_group|
  user_group.each do |name|
    # Generate an email from the name
    email = name.gsub(/\s+/, "").downcase + "@example.com"
    
    # Create the user
    unless User.find_by_email(email)
      # If the gender is "custom", set the custom gender and preferred pronouns
      custom_gender = nil
      pronouns = nil
      
      if gender == 4
        custom_gender = ["agender", "androgyne", "bigender", "demiboy", "demigirl", "femme", "genderfluid", "genderqueer", "neutrosis", "nonbinary", "polygender", "queer"].sample
        pronouns = User.pronouns.to_a.sample[1]
      end
      
      User.create!(
        name: name,
        email: email,
        password: "testtest",
        role: :user,
        password_confirmation: "testtest",
        city: cities.sample,
        state: states.sample,
        birthday: rand(Date.civil(1970, 1, 1)..Date.civil(2000, 10, 1)),
        gender: gender,
        custom_gender: custom_gender,
        pronouns: pronouns
      )
    end
  end
end

# Make friends
User.all.each do |user|
  user.add_friend(User.all.sample)
end

# Create businesses
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
    rand(2..20).times do
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
