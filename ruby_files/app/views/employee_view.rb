
class EmployeeView
  def list_employees(employees)
    employees.each do |employee|
      puts "#{employee.id}:  #{employee.name} - #{employee.role}"
    end
  end
end