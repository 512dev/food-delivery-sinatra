require_relative '../repositories/order_repository.rb'
require_relative '../models/order.rb'
require_relative '../views/order_view.rb'

class OrdersController
  def initialize(meals, employees, customers, orders)
    @meals = meals
    @employees = employees
    @customers = customers
    @orders = orders
    @view = OrderView.new
  end

  def list_undelivered_orders
    @view.list_orders(@orders.undelivered_orders)
  end

  def add
    new_order = @view.add_order
    order_to_add = Order.new(meal: @meals.find(new_order[:meal_id]),
                             employee: @employees.find(new_order[:employee_id]),
                             customer: @customers.find(new_order[:customer_id]))
    @orders.add(order_to_add)
  end

  def list_my_orders(employee)
    orders = @orders.undelivered_orders
    @view.list_user_orders(orders, employee)
  end

  def mark_as_delivered(employee)
    delivered_id = @view.delivered
    @orders.undelivered_orders.each do |order|
      if employee.username == order.employee.username && order.id == delivered_id
        order.deliver!
      end
      @orders.add(order)
    end
  end
end
