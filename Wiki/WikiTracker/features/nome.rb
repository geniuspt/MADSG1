Feature: Get User Stories
  In order to know many user stories i have
  As a developer 
  I want to be told the number of existing user stories

  Scenario Outline: Retrieve related user stories correctly
	Given I have entered id <input_1> into the function getByProject
    When I ask for related user stories
    Then the result should have <number> elements
    
  Examples:
    | input_1     | number  | 
    | 416129      | 7       | 
