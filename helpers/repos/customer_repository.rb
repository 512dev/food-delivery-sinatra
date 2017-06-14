require 'csv'
require_relative 'base_repository'

class CustomerRepository < BaseRepository
  def initialize(csv_file_path)
    super
    @next_id = @elements.empty? ? 1 : @elements.last.id + 1
  end

  def add(element)
    element.id = @next_id
    @elements << element
    @next_id += 1
    write_csv
  end

  def build_element(row)
    row[:id] = row[:id].to_i # Convert column to Fixnum
    Customer.new(row)
  end

  def delete(index)
    @elements.delete_at(index)
    write_csv
  end
end
