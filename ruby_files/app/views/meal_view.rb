
class MealView
  def list_meals(meals)
    meals.each do |meal|
      puts "#{meal.id}:  #{meal.name} - $#{meal.price}"
    end
  end

  def add_meal
    puts "Meal?"
    name = gets.chomp
    puts "Price?"
    price = gets.chomp.to_i
    { name: name, price: price }
  end

  def delete_meal(meals)
    puts "Which meal would you like to delete?"
    meals.each_with_index do |meal, index|
      puts "#{index}:  #{meal.name} - $#{meal.price}"
    end
    gets.chomp.to_i
  end
end