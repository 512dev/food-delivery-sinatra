require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "helpers/repos/employee_repository"
require_relative "helpers/repos/meal_repository"
require_relative "helpers/repos/customer_repository"
require_relative "helpers/repos/order_repository"
require_relative "helpers/models/employee"
require_relative "helpers/models/meal"
require_relative "helpers/models/order"
require_relative "helpers/models/customer"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end
employee_csv = File.join(__dir__, 'helpers/data/employees.csv')
EMPLOYEES = EmployeeRepository.new(employee_csv)
meal_csv = File.join(__dir__, 'helpers/data/food.csv')
MEALS = MealRepository.new(meal_csv)
customers_csv = File.join(__dir__, 'helpers/data/customers.csv')
CUSTOMERS = CustomerRepository.new(customers_csv)
orders_csv = File.join(__dir__, 'helpers/data/orders.csv')
ORDERS = OrderRepository.new(orders_csv, MEALS, EMPLOYEES, CUSTOMERS)

get '/' do
  erb :index
end

get '/manager' do
  erb :manager
end

get '/delivery_guy' do
  erb :delivery_guy
end

post '/login' do
  user = EMPLOYEES.find_by_username(params[:username])
  if user && user.password == params[:password] && user.manager?
    redirect '/manager'
  elsif user && user.password == params[:password]
    redirect '/delivery_guy'
  else
    redirect '/'
  end
end
