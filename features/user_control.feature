Feature: User Add/Remove

  As a College Track admin,
  So that I can add and remove users to the database
  I want to have an admin-only page where I can add/remove users

Background: Users have been added to the database

<<<<<<< HEAD
  Given the following users exist:
  | name                   | email               | role | password |
  | Aladdin                | magiclamp@gmail.com | User | password |
  | Iago                   | othello@gmail.com   | Admin| password |
  And I am on the login page
  And I login as "othello@gmail.com"
  Then I should be on the email page
=======
  Given I am an admin
  And the following users exist:
  | name                   | email               | role |
  | Aladdin                | magiclamp@gmail.com | user |
  | Iago                   | othello@gmail.com   | admin|
>>>>>>> 43c1d211bec3183ed048e68b3a894d9c59a6d836

Scenario: Accessing admin page

  Given I am on the email page
  And I click the admin tab
  Then I should be on the admin page

Scenario: Adding a user

  Given I am on the admin page
  And I fill in 'Name' with "Admin"
  And I fill in 'Email' with "admin@collegetrack.com"
  And I click '+' to add a new user
  Then I should see "admin@collegetrack.com"
  And I should be on the admin page

Scenario: Removing a user

  Given I am on the admin page
<<<<<<< HEAD
=======
<<<<<<< HEAD
  And I click "X" to remove user "Aladdin"
  Then I should not see "Aladdin"
  And I should not see "magiclamp@gmail.com"
  But I should see "Iago"
  And I should see "othello@gmail.com"
  And I should be on the admin page
=======
>>>>>>> 387240040a160293fbd9815652d1112c480f2e60
  And I click the "X" on the user “Aladdin”
  Then I should not see “Aladdin”
  And I should not see “magiclamp@gmail.com”
  But I should see “Iago”
  And I should see “othello@gmail.com”
>>>>>>> 43c1d211bec3183ed048e68b3a894d9c59a6d836
