class Router
  def initialize(meals_controller, customers_controller, sessions_controller, orders_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @orders_controller = orders_controller
    @running = true
    @user = nil
  end

  def run
    puts "Welcome to the the Cafe!"
    puts "           --           "
    @user = @sessions_controller.sign_in
    if @user.manager?
      while @running
        display_manager_tasks
        action = gets.chomp.to_i
        print `clear`
        manager_route_action(action)
      end
    else
      while @running
        display_delivery_tasks
        action = gets.chomp.to_i
        print `clear`
        delivery_route_action(action)
      end
    end
  end

  private

  def manager_route_action(action)
    case action
    when 1 then @meals_controller.list
    when 2 then @customers_controller.list
    when 3 then @meals_controller.add
    when 4 then @customers_controller.add
    when 5 then @orders_controller.add
    when 6 then @orders_controller.list_undelivered_orders
    when 7 then @meals_controller.delete
    when 8 then @customers_controller.delete
    when 0 then stop
    else
      puts "Please select a number option from above"
    end
  end

  def delivery_route_action(action)
    case action
    when 1 then @orders_controller.list_my_orders(@user)
    when 2 then @orders_controller.mark_as_delivered(@user)
    when 0 then stop
    else
      puts "Please select a number option from above"
    end
  end

  def stop
    @running = false
  end

  def display_manager_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List all menu items"
    puts "2 - List customers"
    puts "3 - Add a meal"
    puts "4 - Add a customer"
    puts "5 - Add an Order"
    puts "6 - Show undelivered orders"
    puts "7 - Delete a meal"
    puts "8 - Delete a customer"
    puts "0 - Stop and exit the program"
  end

  def display_delivery_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - List my orders"
    puts "2 - Mark an order as delivered"
    puts "0 - Stop and exit the program"
  end
end
