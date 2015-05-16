class Department < Employee
  attr_reader :employees, :name, :reviews, :salary
  def initialize(name:)
    @name = name
    @employees = []
    @salary = salary
  end


  def assign(*name)
    name.each {|e| @employees << e}
  end

  def total_salary
    @employees.reduce(0) {|sum, e| e.salary + sum}
  end

  def increase(amount)
    eligible = @employees.select {|e| yield(e)}
    pay = amount/(eligible.length)
    eligible.each {|e| e.salary = (pay + e.salary)}
#     department.give_raises(5000) do |employee|
#   employee.salary < 100000
# end
   end
end


# {:Draper => 1500, :Sterling => 2000, :Cooper => 1000, :Price => 750}
