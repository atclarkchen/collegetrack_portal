Feature: Salesforce Password Change

  As a College Track Portal staff,
  So that I can’t send an email if the Salesforce password is outdated
  I want to have an admin-only page where I can update the security token and password

Background: There exists one authorized user and one authorized admin
  Given the following users exist:
  | name                 | email           | role  | password |
  | Admin                | admin@gmail.com | Admin | password |
  | User                 | user@gmail.com  | User  | password |

Scenario: User cannot reset Salesforce password
  
  When I login as a user@gmail.com
  And the password is outdated
  Then I should see "Your Salesforce account is invalid or not authorized. Please contact an admin”

Scenario: Admin can reset Salesforce password
  
  When I login as admin@gmail.com
  And the Salesforce password is outdated
  Then I should see “Reset Salesforce Password”