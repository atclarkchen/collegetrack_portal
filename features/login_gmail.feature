Feature: login through Gmail

  As a College Track staff,
  So that I can email groups of students using my Gmail account,
  I want to link my Gmail account to this webapp

Scenario: Signing in with Gmail for the first time
  When I go to the login page
  And I click "Sign in with Gmail"
  And I am logged into Gmail
  And I am an authorized user
  Then I should see the Salesforce login page

Scenario: Signing in with Gmail after the first time
  When I go to the login page
  And I click "Sign in with Gmail"
  And I am logged into Gmail
  And I am an authorized user
  Then I should see the email page

Scenario: Signing in with Gmail as an unauthorized user
  When I go to the login page
  And I click "Sign in with Gmail"
  And I am logged into Gmail
  And I am an unauthorized user
  Then I should be redirect to the login page
  And I should see the "This email is not authorized. Please log out and log in with an authorized account. Contact an admin if not yet authorized"
  And I click "log out"
  Then I should see login page
  And I should see the email and password fields

Scenario: Redirect to login from authorized user page
  When I am on the unauthorized user page
  Then I should see "Contact Admin if not yet authorized"
  And I click "Return to login page"
  Then I should see the login page

Scenario: Signing in with Gmail when not already logged in
  When I go to the login page
  And I click "Sign in with Gmail"
  And I am not logged into Gmail
  And I am an authorized user
  Then I should see the email and password fields
  And I fill in "validemail@gmail.com" in the email field
  And I fill in "password" in the password field
  And I click "Sign in with Gmail"
  Then I should see the email page
