Feature: Salesforce Password Change

  As a College Track Portal staff,
  So that I can’t send an email if the Salesforce password is outdated
  I want to have an admin-only page where I can update the security token and password

Background:
  Given I am an authorized staff
  When the Salesforce password is updated
  Only an admin can update it on the application

Scenario: User cannot reset Salesforce password
  
  When I login as a user
  And the password is outdated
  Then I should see “Salesforce password outdated, please contact to an Admin”

Scenario: Admin can reset Salesforce password
  
  When I login as an admin
  And the password is outdated
  Then I should see “Reset Salesforce Password”
