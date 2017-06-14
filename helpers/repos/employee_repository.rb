require 'csv'
require_relative 'base_repository'

class EmployeeRepository < BaseRepository
  def initialize(csv_file_path)
    super
    @next_id = @elements.empty? ? 1 : @elements.last.id + 1
  end

  def build_element(row)
    row[:id] = row[:id].to_i # Convert column to Fixnum
    Employee.new(row)
  end

  def all_delivery_guys
    @elements.select do |employee|
      employee.role == "delivery_guy"
    end
  end

  def find_by_username(name)
    @elements.detect do |employee|
      employee.username == name
    end
  end
end
