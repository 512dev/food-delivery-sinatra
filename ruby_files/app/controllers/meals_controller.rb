require_relative '../repositories/meal_repository.rb'
require_relative '../models/meal.rb'
require_relative '../views/meal_view.rb'

class MealsController
  def initialize(repo)
    @meals = repo
    @view = MealView.new
  end

  def list
    @view.list_meals(@meals.all)
  end

  def add
    new_meal = @view.add_meal
    @meals.add(Meal.new(new_meal))
  end

  def delete
    meal_index = @view.delete_meal(@meals.all)
    @meals.delete(meal_index)
  end
end