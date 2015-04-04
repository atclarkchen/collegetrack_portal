Feature: User Add/Remove

  As a College Track admin,
  So that I can add and remove users to the database
  I want to have an admin-only page where I can add/remove users

Background: Users have been added to the database

  Given I am an admin
  And the following users exist:
  | name                   | email               | type |
  | Aladdin                | magiclamp@gmail.com | user |
  | Iago                   | othello@gmail.com   | admin|

Scenario: Accessing admin page

  Given I am on the email page
  And I click the admin tab
  Then I should be on the admin page

Scenario: Adding a user

  Given I am on the admin page
  And I fill in “admin@collegetrack.com”
  Then I should see “admin@collegetrack.com”

Scenario: Removing a user

  Given I am on the admin page
  And I click the “Remove button” on the user “Aladdin”
  Then I should not see “Aladdin”
  And I should not see “magiclamp@gmail.com”
  But I should see “Iago”
  And I should see “othello@gmail.com”
