FactoryGirl.define do
  factory :user do
    sequence(:name){ |n| "user#{n}" }
    email { "#{name}@example.com" }
    password "secretpassword"
    password_confirmation "secretpassword"
    city "Anytown"
    state "NE"

    factory :admin do
      role :admin
    end
    
    factory :business_admin do
      role :business_admin
    end
  end
end
