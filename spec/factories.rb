# Add Factories here

# Examples are shown below

FactoryGirl.define do

  factory :token do
    access_token   "MyString"
    refresh_token  nil
    expires_at     "2015-03-31 21:20:22"
  end

  factory :user do
    email     "test@sample.com"
    password  "password"
  end

end