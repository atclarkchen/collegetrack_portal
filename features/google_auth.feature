Feature: login through Google

  As a College Track staff,
  So that I can email groups of students using my Google account,
  I want to link my Google account to this webapp

Background: Any user must pass Google authentication
  
  Given I am on the login page
  And I should see "Sign in with Google"

Scenario: Signing in with Google for the first time
  Given I am an unauthorized user
  When I press "Sign in with Google"
  Then I should be on email page