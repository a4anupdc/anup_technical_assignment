# frozen_string_literal: true

Given('I visit todo applications home page') do
  visit TODO_APP_BASE_URL
  sleep 10
  @count_todo_items = 0
  @footer_counter_text = ''
  @count_todo_items = find('.todo-count strong').text.to_i if page.has_css?('.footer')
end

When('I enter text {string} in todo box and hit enter') do |text|
  @text = text
  find('.new-todo').fill_in(with: text).native.send_keys(:return)
end

Then('I should see {string} item added to todo list') do |text|
  expect(page).to have_css('ul.todo-list li:last-child label', text: text.to_s)
  expect(page).to have_css('span.todo-count')
  expect(page).to have_link('All', href: '#/')
  expect(page).to have_link('Active', href: '#/active')
  expect(page).to have_link('Completed', href: '#/completed')
end

Given('I make sure that {string} logo is present on screen') do |logo_text|
  expect(page).to have_css('h1', text: logo_text.to_s)
end

Given('textbox is present on screen with default text {string}') do |text|
  expect(page).to have_css(".new-todo[placeholder=\"#{text}\"]")
end

When('I double click on todo item {string} and update its value to {string}') do |old_text, new_text|
  @text = new_text
  find('.todo-list li:last-child label', text: old_text.to_s).double_click
  find('.todo-list li:last-child.editing input.edit').fill_in(with: new_text).native.send_keys(:return)
end

Then('I should see updated item with text {string} in todo list') do |new_text|
  expect(page).to have_css('.todo-list label', text: new_text.to_s)
end

When('I delete last item added to todo list') do
  find('.todo-list li:last-child label', text: @text.to_s).hover
  find('button.destroy').click
end

Then('I should not see deleted todo item on screen') do
  expect(page).to have_no_css('.todo-list li:last-child label', text: @text.to_s)
end

Then('I should see to-do counter {string} by {int}') do |operation, number|
  operation.eql?('increament') ? @count_todo_items += number : @count_todo_items -= number
  expect(page).to have_css('.todo-count strong', text: @count_todo_items.to_s)
end

When('I click on toggle-all checkbox') do
  find('.toggle-all + label').click
end

Then('I should see that all todo tasks are marked as completed') do
  expect(page).to have_css('.todo-list li.completed', count: @count_todo_items)
  expect(page).to have_button('Clear completed')
end

Then('I should see that to-do counter is set to {int}') do |counter_value|
  expect(find('.todo-count strong').text.to_i).to eq(counter_value.to_i)
  @count_todo_items = counter_value
end

Given('I run steps to add 2 different todo in page') do
  steps %(
  When I enter text "Todo number 1" in todo box and hit enter
	Then I should see "Todo number 1" item added to todo list
	And I should see to-do counter "increament" by 1
	When I enter text "Todo number 2" in todo box and hit enter
	Then I should see "Todo number 2" item added to todo list
	And I should see to-do counter "increament" by 1
  )
end

When('I click on {string} link') do |link_text|
  link_text.eql?('Clear completed') ? (click_button link_text.to_s) : (click_link link_text.to_s)
end

When('I mark one of newly added todo task as complete') do
  find('.todo-list li:last-child .toggle', visible: false).click
  expect(page).to have_button('Clear completed')
end

Then('I should see only {string} todo items') do |status_of_todo_item|
  page.find('.todo-list').all('li') do |element|
    case status_of_todo_item
    when 'Completed'
      expect(element[:class]).to eq('completed')
    when 'Active'
      expect(element[:class]).to eq('')
    when 'All'
      expect(element[:class]).to eq('') or expect(element[:class]).to eq('completed')
    end
  end
end

When('I uncheck to-do task number {int}') do |task_number|
  find_all('.todo-list li')[task_number.to_i - 1].find('.toggle', visible: false).click
end

Given('I should not see "Clear completed" button on screen') do
  expect(page).to have_no_button('Clear completed')
end
