require 'csv'
require_relative 'base_repository'

class MealRepository < BaseRepository
  def initialize(csv_file_path)
    @filepath = csv_file_path
    @meals = []
    load_csv if File.exist?(@filepath)
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
  end

  def all
    @meals
  end

  def add(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_csv
  end

  def find(id)
    @meals.detect { |meal| meal.id == id }
  end

  def delete(index)
    @meals.delete_at(index)
    save_csv
  end

  private

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@filepath, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      @meals << Meal.new(row)
    end
    return @meals
  end

  def save_csv
    CSV.open(@filepath, 'wb') do |csv|
      csv << ["id", "name", "price"]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end
