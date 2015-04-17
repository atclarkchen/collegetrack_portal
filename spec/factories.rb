# Add Factories here

# Examples are shown below

include ActionDispatch::TestProcess

FactoryGirl.define do
  
  factory :attachment do
    file { fixture_file_upload(Rails.root.join('spec/fixtures/image.gif'), 'image/gif') }
  end

  factory :draft do
    to  "to@gmail.com"
    cc  "cc@gmail.com"
    bcc "bcc@gmail.com"
    subject "Test Subject"
    body "This is body"

    # draft = create(:draft_with_attachment)
    factory :draft_with_attachment do |attachment|
      after(:create) do |draft|
        create(:attachment, draft: draft)
      end
    end
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

    # associations
    draft
    token
  end

end