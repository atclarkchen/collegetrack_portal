Feature: Showing the email page for authorize user only
  As a College Track staff,
  In order to protect the student information,
  I want to show the email page for authorized user only

Scenario: Email page should not be access by an unauthorized user
  Given I am an unauthorized user
  When I try to go to the email page
  Then I should be redirected to the loggin with the google page

Scenario: An authorized user should see the full email page
  Given I am logged into as an authorized user
  When I am on the email page
  Then I should see the following fields: to, cc, bcc, subject, body
  And I should see the following buttons: send, delete, filter, draft