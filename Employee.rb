class Employee
  attr_reader :name, :email, :phone_number, :salary, :reviews, :satisfactory
def initialize(name, email, phone_number, salary=0)
  @name = name
  @salary = salary
  @email = email
  @phone_number = phone_number
  @reviews = []
  @satisfactory = nil
end

def add_review(review)
  @reviews << review
end

def performance(value)
  @satisfactory = value
  # if value == true
  #   @satisfactory = true
  # else
  #   @satisfactory = false
  # end
end

end
