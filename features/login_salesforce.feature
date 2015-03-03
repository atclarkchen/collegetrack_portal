Feature: Login through Salesforce:
  
  As a College Track staff,
  So that I can access to the student records on Salesforce
  I want to link my salesforce account to this webapp

  Scenario: Signing in with Salesforce as an authorized user
    When I am on the Saleforce login page
    And I fill in “salesforceemail@email.com” in the email field
    And I fill in “password” in the password field
    And I click “Sign in with Salesforce”
    And I am an authorized user
    Then I should see the Email page

  Scenario: Signing in with Salesforce as an unauthorized user
    When I am on the Saleforce login page
    And I fill in “unauthorizedemail@email.com” in the email field
    And I fill in “password” in the password field
    And I click “Sign in with Salesforce”
    And I am an unauthorized user
    Then I should see “Not an authorized account. Please contact an admin”
    And I should see the email and password fields
