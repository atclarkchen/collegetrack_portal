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