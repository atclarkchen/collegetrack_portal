@javascript
Feature: Filter students to email by categories

  As a College Track staff,
  So I can send emails to specific groups
  I want to be able to filter through groups of students

Background: Users have been added to the database  

  Given the following users exist:
  | email                   | password |
  | petrduong@gmail.com     | password |
  | jason.chern93@gmail.com | password |
  | shinyenhuang@gmail.com  | password |

  And I am on the login page
  And I login as "petrduong@gmail.com"

Scenario: Add a single filter with default filter selected

  Given I see the filters: Oakland
  And I add the filters: 2010
  Then the recipient fields should contain: asianM2010@gmail.com whiteM2010@gmail.com blackM2010@gmail.com asianF2010@gmail.com whiteF2010@gmail.com blackF2010@gmail.com

Scenario: Adding multiple filters with existing filters

  Given I see the filters: Oakland,2010
  And the recipient fields should contain: asianM2010@gmail.com whiteM2010@gmail.com blackM2010@gmail.com asianF2010@gmail.com whiteF2010@gmail.com blackF2010@gmail.com
  And I add the filters: White
  Then the recipient fields should contain: whiteM2010@gmail.com whiteF2010@gmail.com 

Scenario: Removing a single filter through the x button

  Given I see the filters: Oakland,2010,Female
  And the recipient fields should contain: asianF2010@gmail.com whiteF2010@gmail.com blackF2010@gmail.com
  And I click the x button on "Female"
  Then the recipient fields should contain: asianM2010@gmail.com whiteM2010@gmail.com blackM2010@gmail.com asianF2010@gmail.com whiteF2010@gmail.com blackF2010@gmail.com

Scenario: Deselecting filters by changing filters

  Given I see the filters: Oakland,2010,Female,White
  And the recipient fields should contain: whiteF2010@gmail.com
  And I remove the filters: White
  Then the recipient fields should contain: asianF2010@gmail.com whiteF2010@gmail.com blackF2010@gmail.com

Scenario: Removing and Adding filters in one filter change

  Given I see the filters: Oakland,2012,Female,Black
  And the recipient fields should contain: blackF2012@gmail.com
  And I remove the filters: Black
  Then the recipient fields should contain: asianF2012@gmail.com whiteF2012@gmail.com blackF2012@gmail.com
