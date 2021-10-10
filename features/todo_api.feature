Feature: In this feature file, we will be testing various scenario (e.g. Add/Edie/Delete todo) related to todo functionality using API.

Scenario: Make POST request to create new todo task.
	When I make POST request to create new todo task
		| userId 	| title 					|
		|	1				| To Do tomorrow 	|
	Then I should get 201 response code

Scenario: Make a GET request to fetch all todo for a specific user.
	When I make GET request to fetch all todo items for userId 1
	Then I should get 200 response code
	And I should see all todo items for this userId

Scenario: Make a GET request to fetch all todo itmes.
	When I make GET request to fetch all todo items
	Then I should get 200 response code
	And I should see all todo items

Scenario: Make a PUT request to mark all todo itmes as completed=true for a particular user.
	When I make GET request to fetch all todo items for userId 8
	Then I should get 200 response code
	And I make PATCH request to update all incomplete todo items as complete for this userId

Scenario: Make a PUT request to mark specific todo itme as completed=true for a particular user.
	When I make GET request to fetch all todo items for userId 6
	Then I should get 200 response code
	And I make PATCH request to update todo item id 114 as complete

Scenario: Delete all completed todo items for a particular user.
	When I make GET request to fetch all todo items for userId 7
	Then I should get 200 response code
	And I make DELETE request to delete all completed todo items

Scenario: Delete specific completed todo item for a particular user.
	When I make GET request to fetch all todo items for userId 10
	Then I should get 200 response code
	And I make DELETE request to delete todo item id 199