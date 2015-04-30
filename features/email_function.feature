  Feature: Sending an Email as an authorized user
  As a College Track staff,
  In order to contact students without copy and pasting from salesforce database,
  I want to be able to email students from one web app.

Background:
  Given the following users exist:
  | email           | password |
  | user@sample.com | password |

  Given I am on the login page
  Then I am logged into as "user@sample.com"

Scenario: Successfully sending email
  Given I compose the following email:
  | to      | mail_to@gmail.com                   |
  | cc      | mail_cc@gmail.com                   |
  | bcc     | mail_bcc@gmail.com                  |
  | subject | Hello from CollegeTrack             |
  | body    | Test message from CollegeTrack      |

  When I press "Send"
  Then I should be on the email page
  And all fields on the email page should be empty

Scenario: Should be able to reset message
  Given I compose the following email:
  | to      | mail_to@gmail.com                   |
  | cc      | mail_cc@gmail.com                   |
  | bcc     | mail_bcc@gmail.com                  |
  | subject | Hello from CollegeTrack             |
  | body    | Test message from CollegeTrack      |
  
  When I follow "Delete"
  Then I should be on the new email page
  And all fields on the email page should be empty

Scenario: Successfully save email draft
  Given I compose the following email:
  | to      | mail_to@gmail.com                   |
  | cc      | mail_cc@gmail.com                   |
  | bcc     | mail_bcc@gmail.com                  |
  | subject | Hello from CollegeTrack             |
  | body    | Test message from CollegeTrack      |
  When I press "Draft"
  Then I should be on the email page
  And all fields on the email page should be empty

# Scenario: Successfully undo the sent email
#   Given I fill in “to field” with “asianM2010@gmail.com”
#   And I fill in “cc field” with “whiteF2010@gmail.com”
#   And I fill in “bcc field” with “blackF2012@gmail.com”
#   And I fill in “subject field” with “Hello from CollegeTrack!”
#   And I fill in “body field” with “This is a message from CollegeTrack!”

#   When I press “Send”
#   Then I should see “Undo Send”
#   And I wait “5” seconds
#   And I press “Undo Send”
#   Then I should see “Message was not sent per your request”