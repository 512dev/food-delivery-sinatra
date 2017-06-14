class Meal
  attr_reader :name, :price
  attr_accessor :id
  def initialize(args = {})
    @name = args[:name]
    @price = args[:price]
    @id = args[:id]
  end

  def to_csv_row
    [@id, @name, @address]
  end

  def self.headers
    %w[id name address]
  end
end