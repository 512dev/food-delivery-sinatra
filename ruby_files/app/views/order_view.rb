class OrderView
  def list_orders(orders)
    orders.each do |order|
      puts "#{order.id}:  #{order.meal.name} needs to be delivered to #{order.customer.name}
             by #{order.employee.username}"
    end
  end

  def add_order
    puts "What is the meal id?"
    meal_id = gets.chomp.to_i
    puts "What is the customer id?"
    customer_id = gets.chomp.to_i
    puts "What is the id of the delivery guy?"
    employee_id = gets.chomp.to_i
    { meal_id: meal_id, customer_id: customer_id, employee_id: employee_id }
  end

  def list_user_orders(orders, employee)
    orders.each do |order|
      if employee.username == order.employee.username
        puts "#{order.customer.name}  #{order.meal.name}"
      end
    end
  end

  def delivered
    puts "ID of Order delivered?"
    gets.chomp.to_i
  end
end