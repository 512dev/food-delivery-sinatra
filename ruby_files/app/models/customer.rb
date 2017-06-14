class Customer
  attr_reader :name, :address
  attr_accessor :id
  def initialize(args = {})
    @name = args[:name]
    @address = args[:address]
    @id = args[:id]
  end

  def to_csv_row
    [@id, @name, @address]
  end

  def self.headers
    %w[id name address]
  end
end