Feature: In this feature file, we will be testing various scenario related to todo page such as create new todo, delete todo, mark todo as complete

Scenario: User is able to add new item to todo list
	Given I visit todo applications home page
	And I make sure that "todos" logo is present on screen
	And textbox is present on screen with default text "What needs to be done?"
	When I enter text "Todo number 1" in todo box and hit enter
	Then I should see "Todo number 1" item added to todo list
	And I should see to-do counter "increament" by 1
	When I enter text "Todo number 2" in todo box and hit enter
	Then I should see "Todo number 2" item added to todo list
	And I should see to-do counter "increament" by 1

Scenario Outline: User is able to edit item once its added to todo list
	Given I visit todo applications home page
	When I enter text "<todo_item>" in todo box and hit enter
	Then I should see "<todo_item>" item added to todo list
	When I double click on todo item "<todo_item>" and update its value to "<updated_text>"
	Then I should see updated item with text "<updated_text>" in todo list

Examples:
	|	todo_item			| updated_text 					|
	| Todo number 3 | Updated Todo number 3 |
	| Todo number 4 | Updated Todo number 4 |

Scenario: User is able to delete item once its added to todo list
	Given I visit todo applications home page
	And I run steps to add 2 different todo in page 
	When I delete last item added to todo list
	Then I should not see deleted todo item on screen
	And I should see to-do counter "decreament" by 1

Scenario: User is able to select all items and mark them as completed
	Given I visit todo applications home page
	And I run steps to add 2 different todo in page
	When I click on toggle-all checkbox
	Then I should see that all todo tasks are marked as completed
	And I should see that to-do counter is set to 0
	When I uncheck to-do task number 2
	Then I should see to-do counter "increament" by 1
	When I uncheck to-do task number 1
	Then I should see to-do counter "increament" by 1
	When I click on toggle-all checkbox
	Then I should see that all todo tasks are marked as completed
	And I should see that to-do counter is set to 0

Scenario: User is able to filter Active and completed todo items
	Given I visit todo applications home page
	And I run steps to add 2 different todo in page
	And I mark one of newly added todo task as complete 
	When I click on "Completed" link
	Then I should see only "Completed" todo items
	When I click on "Active" link
	Then I should see only "Active" todo items
	When I click on "All" link
	Then I should see only "All" todo items

Scenario: User is able delete complete todo items using Clear Completed link
	Given I visit todo applications home page
	And I run steps to add 2 different todo in page
	And I should not see "Clear completed" button on screen
	And I mark one of newly added todo task as complete 
	When I click on "Clear completed" link
	Then I should not see deleted todo item on screen
	And I should see to-do counter "decreament" by 1




