# Add Factories here

# Examples are shown below

FactoryGirl.define do

  factory :token do
    access_token "MyString"
    refresh_token nil
    expires_at "2015-03-31 21:20:22"
  end

  factory :user do
    first_name "John"
    last_name  "Doe"
    admin false
  end

end