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

end
