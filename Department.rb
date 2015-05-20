class Department <ActiveRecord::Base
  # attr_reader :name, :email, :phone_number, :reviews, :satisfactory
   #attr_accessor :salary
  has_many :employees


  def assign(name)
    employees << name
  end

  def total_salary
    employees.reduce(0) {|sum, e| e.salary + sum}
  end

  def increase(amount)
    eligible = employees.select {|e| yield(e)}
    pay = amount/(eligible.length)
    eligible.each {|e| e.salary = (pay + e.salary)}
  end

  def arrange(field)
    field.order
  end

 def employees_above_average_salary
   total = employees.map {|employee| employee.salary}
   average = total.reduce(:+)/employees.count
   employees.select {|employee| employee.salary > average}
 end

  def palindrome
    array = employees.map do |employees|
      employees.name.reverse.downcase
    end
     return backwards_names = array.reject {|n| n.reverse.downcase != n.downcase}
  end

  def employee_count
    match = []
    division_id = Department.all.map do |d|
      Employee.all.map do |e|
        if d.id == e.department_id
          match << d.name
        end
      end
    end
    match
    count = Hash.new{0}
    match.each {|match| count[match] +=1}
    count.flatten
  end
end
