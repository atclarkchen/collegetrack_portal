@javascript
Feature: User Add/Remove

  As a College Track admin,
  So that I can add and remove users to the database
  I want to have an admin-only page where I can add/remove users

Background: Users have been added to the database

  Given the following users exist:
  | name                   | email               | role | password |
  | Aladdin                | magiclamp@gmail.com | User | password |
  | Iago                   | othello@gmail.com   | Admin| password |
  And I am on the login page
  And I login as "othello@gmail.com"
  And I click the admin tab
  
Scenario: Accessing admin page
  Then I should be on the admin page

Scenario: Adding a user
  Given I fill in 'Email' with "admin@collegetrack.com"
  And I click '+' to add a new user
  Then I should see "admin@collegetrack.com"
  And I should be on the admin page

Scenario: Removing a user
  Given I click "X" to remove user "magiclamp@gmail.com"
  And I should not see "magiclamp@gmail.com"
  And I should see "othello@gmail.com"
  And I should be on the admin page
