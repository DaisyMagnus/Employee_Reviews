class Department < Employee
  attr_reader :employees, :name, :reviews, :salary
  def initialize(name)
    @name = name
    @employees = []
    @salary = salary
  end


  def assign(*name)
    @employees << name
  end

  def total_salary
    @employees.reduce {|sum, e| e.salary + sum}

  end

  # def add_reviews
  #   @reviews.merge!(name: "")
  # end

end


# {:Draper => 1500, :Sterling => 2000, :Cooper => 1000, :Price => 750}
