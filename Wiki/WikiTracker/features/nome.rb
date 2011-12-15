Feature: Addition
  In order to avoid silly mistakes
  As a math idiot 
  I want to be told the sum of two numbers

  Scenario Outline: Retrieve related pages correctly
    Given I have entered id 1 into the function get_related_pages
	When i press enter
	Then the page.user_id result should be 1