class Employee
  attr_accessor :id, :username, :password, :role
  def initialize(args = {})
    @username = args[:username]
    @password = args[:password]
    @id = args[:id]
    @role = args[:role]
  end

  def manager?
    @role == "manager"
  end

  def delivery_guy?
    @role == "delivery_guy"
  end

  def to_csv_row
    [@id, @username, @password, @role]
  end

  def self.headers
    %w[id username password role]
  end
end