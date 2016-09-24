module PostalAbbreviations
  
  # A hash where the keys are the full state name, and the values are the
  # state abbreviation
  def postal_abbreviations_as_hash
    {
      "Alabama" => "AL", "Alaska" => "AK", "American Samoa" => "AS", "Arizona" => "AZ",
      "Arkansas" => "AR", "California" => "CA", "Colorado" => "CO", "Connecticut" => "CT",
      "Delaware" => "DE", "Washington, District of Columbia" => "DC", "Federated States of Micronesia" => "FM",
      "Florida" => "FL", "Georgia" => "GA", "Guam" => "GU", "Hawaii" => "HI", "Idaho" => "ID",
      "Illinois" => "IL", "Indiana" => "IN", "Iowa" => "IA", "Kansas" => "KS", "Kentucky" => "KY",
      "Louisiana" => "LA", "Maine" => "ME", "Marshall Islands" => "MH", "Maryland" => "MD",
      "Massachusetts" => "MA", "Michigan" => "MI", "Minnesota" => "MN", "Mississippi" => "MS",
      "Missouri" => "MO", "Montana" => "MT", "Nebraska" => "NE", "Nevada" => "NV",
      "New Hampshire" => "NH", "New Jersey" => "NJ", "New Mexico" => "NM", "New York" => "NY",
      "North Carolina" => "NC", "North Dakota" => "ND", "Northern Mariana Islands" => "MP", 
      "Ohio" => "OH", "Oklahoma" => "OK", "Oregon" => "OR", "Palau" => "PW", "Pennsylvania" => "PA",
      "Puerto Rico" => "PR", "Rhode Island" => "RI", "South Carolina" => "SC", "South Dakota" => "SD",
      "Tennessee" => "TN", "Texas" => "TX", "Utah" => "UT", "US Minor Outlying Islands" => "UM", 
      "Vermont" => "VT", "Virginia" => "VA", "Virgin Islands" => "VI", "Washington" => "WA",
      "West Virginia" => "WV", "Wisconsin" => "WI", "Wyoming" => "WY", "Armed Forces Americas" => "AA", 
      "Armed Forces Europe" => "AE", "Armed Forces Pacific" => "AP"
    }
  end
  
  # Returns an array of postal abbreviations
  def postal_abbreviations
    self.postal_abbreviations_as_hash.values
  end
  
  # Returns a multidimensional array of state names and their abbreviations
  def postal_abbreviations_as_options
    self.postal_abbreviations_as_hash.to_a.unshift(["State", ""])
  end
  
end