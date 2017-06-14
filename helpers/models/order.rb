class Order
  attr_accessor :id, :meal, :delivered, :employee, :customer
  def initialize(args = {})
    @meal = args[:meal]
    @delivered = args[:delivered] || false
    @id = args[:id]
    @employee = args[:employee]
    @customer = args[:customer]
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end