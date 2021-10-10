echo "Running UI tests"
bundle exec cucumber features/todo_frontend.feature --color --expand --format pretty
echo "Running API tests"
bundle exec cucumber features/todo_api.feature --color --expand --format pretty
