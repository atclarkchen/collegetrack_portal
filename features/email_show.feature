Feature: Showing the email page for authorize user only
  As a College Track staff,
  In order to protect the student information,
  I want to show the email page for authorized user only

Background: Users have been added to the database
  Given the following users exist:
  | email                   | password |
  | user@sample.com         | password |

Scenario: Email page should not be access by an unauthorized user
  When I go to the email page
  Then I should be rejected

Scenario: An authorized user should see the full email page
  Given I am on the login page
  When I try to login as "user@sample.com"
  Then I should be on the email page
  And I should see the following fields: to, cc, bcc, subject, body
  And I should see the following buttons: Send, Draft
  And I should see the following links: Delete