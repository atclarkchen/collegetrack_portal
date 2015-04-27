# Add Factories here

# Examples are shown below

include ActionDispatch::TestProcess

FactoryGirl.define do
  
  factory :attachment do
    source { fixture_file_upload(Rails.root.join('spec/fixtures/image.gif'), 'image/gif') }
  end

  factory :draft do
    to  "to@gmail.com"
    cc  "cc@gmail.com"
    bcc ["bcc1@gmail.com", "bcc2@gmail.com"]
    subject "Test Subject"
    body "This is body"

    # draft = create(:draft_with_attachment)
    # factory :draft_with_attachment do |attachment|
    #   after(:create) do |draft|
    #     create(:attachment, draft: draft)
    #   end
    # end
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

  factory :email, class: Hash do
    to  ["to1@gmail.com", "to2@yahoo.com"]
    cc  ["cc@naver.com"]
    bcc ["bcc1@gmail.com", "bcc2@gmail.com", "bcc3@gmail.com"]
    subject "This is subject"
    body "This is a test body"
    files {{"0" => fixture_file_upload(Rails.root.join('spec/fixtures/image.gif'), 'image/gif'),
            "1" => fixture_file_upload(Rails.root.join('spec/fixtures/sample.pdf'), 'sample/pdf')}}

    initialize_with { attributes }
  end

end