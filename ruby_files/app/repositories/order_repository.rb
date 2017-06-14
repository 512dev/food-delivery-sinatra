require 'csv'
require_relative '../models/order.rb'

class OrderRepository
  def initialize(csv_file_path, meal, employee, customer)
    @filepath = csv_file_path
    @meal_repository = meal
    @customer_repository = customer
    @employee_repository = employee
    @orders = []
    load_csv if File.exist?(@filepath)
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
  end

  def undelivered_orders
    @orders.select do |meal|
      meal.delivered? == false
    end
  end

  def add(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@filepath, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:meal_id] = row[:meal_id].to_i
      row[:delivered] = row[:delivered] == "true"
      row[:employee_id] = row[:employee_id].to_i
      row[:customer_id] = row[:customer_id].to_i
      @orders << Order.new(id: row[:id], delivered: row[:delivered],
                           meal: @meal_repository.find(row[:meal_id]),
                           employee: @employee_repository.find(row[:employee_id]),
                           customer: @customer_repository.find(row[:customer_id]))
    end
    return @orders
  end

  def save_csv
    CSV.open(@filepath, 'wb') do |csv|
      csv << ["id", "meal_id", "employee_id", "customer_id"]
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.employee.id, order.customer.id]
      end
    end
  end
end


