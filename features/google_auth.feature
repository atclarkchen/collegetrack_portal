Feature: login through Google

  As a College Track staff,
  So that I can email groups of students using my Google account,
  I want to link my Google account to this webapp

Background: Users have been added to the database  

  Given the following users exist:
  | email                   | password |
  | petrduong@gmail.com     | password |
  | jason.chern93@gmail.com | password |
  | shinyenhuang@gmail.com  | password |

  And I am on the login page
  Then I should see "Sign in with Google"

Scenario: Signing in as an unauthorized user
  Given I am an unauthorized user
  And I login as "hacker@gmail.com"
  Then I should be rejected

Scenario: Signing in as an authorized user
	Given I am an authorized user
	And I login as "petrduong@gmail.com"
	Then I should be on the new email page