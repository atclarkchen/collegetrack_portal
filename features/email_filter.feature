Feature: Filter students to email by categories

  As a College Track staff,
  So I can send emails to specific groups
  I want to be able to filter through groups of students

Background: Emails have been added to database

Given the following emails and categories exist:
  | email                 | year | race   | gender  | location |
  | asianM2010@gmail.com  | 2010 | asian  | female  | Oakland  |
  | whiteF2010@gmail.com  | 2010 | white  | female  | Oakland  |
  | blackF2012@gmail.com  | 2012 | black  | female  | Oakland  |

And I am on the email page

Scenario: Add a single filter with default filter selected

  Given I only see the filters: Location - Oakland
  And I add the filters: Year - 2010
  Then the recipient fields should contain: asianF2010@gmail.com whiteF2010@gmail.com

Scenario: Adding multiple filters with existing filters

  Given I see the filters: Location - Oakland, Year - 2010
  And the recipient fields should contain: asianF2010@gmail.com whiteF2010@gmail.com
  And I add the filters: Race - White
  Then the recipient fields should contain: whiteF2010@gmail.com 

Scenario: Removing a single filter through the x button

  Given I see the filters: Location - Oakland, Year - 2010, Gender - Female
  And the recipient fields should contain: asianF2010@gmail.com whiteF2010@gmail.com
  And I click the “x” button on “Year - 2010”
  Then the recipient fields should contain: asianF2010@gmail.com whiteF2010@gmail.com blackF2012@gmail.com 

Scenario: Deselecting filters by changing filters

  Given I see the filters: Location - Oakland, Year - 2010, Gender - female, Race - white
  And the recipient fields should only contain: whiteF2010@gmail.com
  And I remove the filters: Race - white
  Then the recipient fields should contain: asianF2010@gmail.com whiteF2010@gmail.com

Scenario: Removing and Adding filters in one filter change

  Given I see the filters: Location - Oakland, Year - 2012, Gender - female, Race - black
  And the recipient fields should only contain: blackF2012@gmail.com
  And I change the filters: Location - Oakland, Year - 2010, Gender - female
  Then the recipient fields should contain: asianF2010@gmail.com whiteF2010@gmail.com
