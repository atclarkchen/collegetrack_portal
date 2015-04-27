Feature: Salesforce Password Change

  As a College Track Portal staff,
  So that I can’t send an email if the Salesforce password is outdated
  I want to have an admin-only page where I can update the security token and password

Background: There exists one authorized user and one authorized admin

  Given the following users exist:
  | name        | email           | role  | password |
  | Admin       | admin@gmail.com | Admin | password |
  | User        | user@gmail.com  | User  | password |

@reset
Scenario: User cannot reset Salesforce password
  
  Given I am on the login page
  And the Salesforce password is outdated
  When I login as "user@gmail.com"
  Then I should be on the login page
  And I should see "Sign in with Google"

@reset
Scenario: Admin can reset Salesforce password
  
  Given I am on the login page
  And the Salesforce password is outdated
  When I login as "admin@gmail.com"
  Then I should be on the Salesforce password reset page
  And I should see "Reset Salesforce Password"

Scenario: Salesforce password cannot be reset if up to date
  
  Given I am on the login page
  And the Salesforce password is up to date
  When I login as "admin@gmail.com"
  Then I should be on the email page
  And I go to the Salesforce password reset page
  Then I should be on the email page
