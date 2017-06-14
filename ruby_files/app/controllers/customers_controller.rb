require_relative '../repositories/customer_repository.rb'
require_relative '../models/customer.rb'
require_relative '../views/customer_view.rb'

class CustomersController
  def initialize(repo)
    @customers = repo
    @view = CustomerView.new
  end

  def list
    @view.list_customers(@customers.all)
  end

  def add
    new_customer = @view.add_customer
    @customers.add(Customer.new(new_customer))
  end

  def delete
    customer_index = @view.delete_customer(@customers.all)
    @customers.delete(customer_index)
  end
end