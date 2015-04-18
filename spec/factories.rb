# Add Factories here

# Examples are shown below

FactoryGirl.define do  
  
  factory :salesforce_client do
    password "MyString"
    security_token "MyString"
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