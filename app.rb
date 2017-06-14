require "sinatra"
require "sinatra/reloader" if development?
require "pry-byebug"
require "better_errors"
require_relative "helpers/repos/employee_repository"
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end
employee_csv    = File.join(__dir__, 'helpers/data/employees.csv')
EMPLOYEES = EmployeeRepository.new(employee_csv)

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
  username
  user = EMPLOYEES.find_by_username(username)
    if user && user.password == password
      redirect "/manager"
    else
      redirect "/login"
    end
end
