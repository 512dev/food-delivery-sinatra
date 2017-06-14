# TODO: require relevant files to bootstrap the app.
# Then you can test your program with:
#   ruby app.rb


require_relative 'app/models/meal.rb'
require_relative 'app/controllers/meals_controller.rb'
require_relative 'app/repositories/meal_repository.rb'
require_relative 'app/controllers/sessions_controller.rb'
require_relative 'app/repositories/employee_repository.rb'
require_relative 'app/repositories/customer_repository.rb'
require_relative 'app/controllers/customers_controller.rb'
require_relative 'app/repositories/order_repository.rb'
require_relative 'app/controllers/orders_controller.rb'
require_relative 'router'

meals_csv_file = File.join(__dir__, './data/food.csv')
meals = MealRepository.new(meals_csv_file)
meals_controller = MealsController.new(meals)

customer_csv_file = File.join(__dir__, './data/customers.csv')
customers = CustomerRepository.new(customer_csv_file)
customers_controller = CustomersController.new(customers)

employee_csv_file = File.join(__dir__, './data/employees.csv')
employees = EmployeeRepository.new(employee_csv_file)
sessions_controller = SessionsController.new(employees)

order_csv_file = File.join(__dir__, './data/orders.csv')
orders = OrderRepository.new(order_csv_file, meals, employees, customers)
orders_controller = OrdersController.new(meals, employees, customers, orders)

router = Router.new(meals_controller, customers_controller, sessions_controller, orders_controller)

router.run