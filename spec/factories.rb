# Add Factories here

# Examples are shown below

FactoryGirl.define do  factory :attachment do
    
  end
  factory :draft do
    
  end


  factory :token do
    access_token   "test-token"
    refresh_token  "test-refresh-token"
    expires_at     Time.now + 3600
  end

  factory :user do
    email     "test@sample.com"
    password  "password"
    role      "User"
  end

end