
Given('I make GET request to fetch all todo items for userId {int}') do |user_id|
	@response = RestClientHelper.get(TODO_APP_API_URL+"?userId=#{user_id}")
	puts @response.code
end

Given('I make GET request to fetch all todo items') do ||
	@response = RestClientHelper.get(TODO_APP_API_URL)
end

Given('I make POST request to create new todo task') do |table|
	table.hashes.each do |hash|
		request_body = JSON.generate({
			"userId" => hash['userId'],
			"id" => find_max_id + 1,
			"title" => hash['title'],
			"completed" => false
		})
		headers = {"Content-Type" => "application/json"}
		@response = RestClientHelper.post(TODO_APP_API_URL, headers, request_body)
	end
end

Then('I should get {int} response code') do |response_code|
	expect(@response.code).to eq(response_code)
end

Then(/^I should see all todo items(?:| for this userId)$/) do
  puts JSON.parse(@response.body)
end

Then('I make PATCH request to update all incomplete todo items as complete for this userId') do
  todo_arr = JSON.parse(@response.body)
  todo_arr.each do |todo|
  	if (todo["completed"] == false)
  		request_body = JSON.generate({
  			"id" => todo["id"],
  			"completed" => true
  		})
  		headers = {"Content-Type" => "application/json"}
  		@response = RestClientHelper.patch(TODO_APP_API_URL+"/#{todo["id"]}", headers, request_body)
  		expect(@response.code).to eq(200)
  		puts "Marked todo id #{todo["id"]} for userId #{todo["userId"]} as Completed"
  	end
  end
end

Then('I make PATCH request to update todo item id {int} as complete') do |todo_task_id|
	todo_arr = JSON.parse(@response.body)
	request_body = JSON.generate({
		"id" => todo_task_id,
		"completed" => true
	})
	headers = {"Content-Type" => "application/json"}
	@response = RestClientHelper.patch(TODO_APP_API_URL+"/#{todo_task_id}", headers, request_body)
	expect(@response.code).to eq(200)
	puts "Marked todo id #{todo_task_id} for userId #{todo_arr[0]["userId"]} as Completed"
end

Then('I make DELETE request to delete all completed todo items') do
  todo_arr = JSON.parse(@response.body)
  todo_arr.each do |todo|
  	if (todo["completed"] == true)
  		@response = RestClientHelper.delete(TODO_APP_API_URL+"/#{todo["id"]}")
  		expect(@response.code).to eq(200)
  		puts "Deleted Completed todo id #{todo["id"]} for userId #{todo["userId"]}"
  	end
  end
end

Then('I make DELETE request to delete todo item id {int}') do |todo_task_id|
	todo_arr = JSON.parse(@response.body)
	@response = RestClientHelper.delete(TODO_APP_API_URL+"/#{todo_task_id}")
	expect(@response.code).to eq(200)
	puts "Deleted todo id #{todo_task_id} for userId #{todo_arr[0]["userId"]}"
end

def find_max_id()
	steps %(
		Given I make GET request to fetch all todo items
	)
	todo_arr = JSON.parse(@response.body)
	max_id = todo_arr[todo_arr.size - 1]["id"]
end