Feature: Sending an Email as an authorized user
  As a College Track staff,
  In order to contact students without copy and pasting from salesforce database,
  I want to be able to email students from one web app.

Background:
  Given the following users exist:
  | email           | password |
  | user@sample.com | password |

  When I am logged into as "user@sample.com"
  Then I am on email page
  And I compose the following email:
  | to                | cc                | bcc                | subject         | body                  |
  | mail_to@gmail.com | mail_cc@gmail.com | mail_bcc@gmail.com | Hello from C.T. | Test message from C.T.|

Scenario: Successfully sending email
  When I press "Send"
  And I wait for "30" seconds
  Then I should see "Message sent successfully"

Scenario: Should be able to delete message
  When I press "Delete"
  Then all fields on the email page should be empty

Scenario: Successfully save email draft
  When I press "Save Draft"
  Then I should see “Draft saved successfully”

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