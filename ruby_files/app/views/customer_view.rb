
class CustomerView
  def list_customers(customers)
    customers.each do |customer|
      puts "#{customer.id}:  #{customer.name} - #{customer.address}"
    end
  end

  def add_customer
    puts "New Customer Name?"
    name = gets.chomp
    puts "#{name}'s Address?"
    address = gets.chomp
    { name: name, address: address }
  end

  def delete_customer(customers)
    puts "Which customer would you like to delete?"
    customers.each_with_index do |customer, index|
      puts "#{index}:  #{customer.name} - #{customer.address}"
    end
    gets.chomp.to_i
  end
end