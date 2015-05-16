require 'minitest/autorun'
require 'minitest/pride'
require 'byebug'
require './Employee.rb'
require './Department.rb'

class EmployeeTest < Minitest::Test

  def test_department_class_exists
    assert Department
  end

  def test_create_new_department_given_name
    assert_equal "Advertising", Department.new(name: "Advertising").name
  end

  def test_create_new_employee_class
    assert Employee
  end

  def test_create_employee_with_name
    don = Employee.new("Don", "don@scdp.com", 1231231234, 10000)
    tom = Employee.new("Tom", "tom@scdp.com", 1231231234, 10000)
    joan = Employee.new("Joan", "joan@scdp.com", 1231235555, 10000)
    assert_equal "Joan", joan.name
    assert_equal "Don", don.name
    end


  def test_add_employee_to_department
    don = Employee.new("Don", "don@scdp.com", 1231231234, 10000)
    pete = Employee.new("Pete", "pete@scdp.com", 1231231234, 10000)
    joan = Employee.new("Joan", "joan@scdp.com", 1231235555, 10000)
    department = Department.new(name: "Advertising")
    department.assign(pete)
    department.assign(don)
    department.assign(joan)
    assert_equal 3, department.employees.length


    # department_salary = @employees.reduce {|sum, e| e.salary + sum}

  end


  def test_get_total_salary_for_department
    don = Employee.new("Don", "don@don.com", 1231231234, 10000)
    tom = Employee.new("Tom", "tom@don.com", 1231231234, 10000)
    joan = Employee.new("Joan", "joan@don.com", 1231235555, 10000)
    department = Department.new(name: "Advertising")
    department.assign(don, tom, joan)
    department.total_salary
  end

  def test_add_text_review_to_employee
    roger = Employee.new("Roger", "roger@scdp.com", 1231235557, 10000)
    roger.add_review("Roger has been a team player and kind soul.")
    assert_equal "Roger has been a team player and kind soul.", roger.reviews[0]
  end

  def test_satisfactorily_or_not
    don = Employee.new("Don", "don@don.com", 1231231234, 10000)
    don.performance(true)
    joan = Employee.new("Joan", "joan@don.com", 1231235555, 10000)
    joan.performance(false)
    assert_equal true, don.satisfactory
    assert_equal false, joan.satisfactory
  end

  def test_give_raise_to_individual
    roger = Employee.new("Roger", "roger@scdp.com", 1231235557, 10000)
    roger.bonus(0.10)
    assert_equal 11000, roger.salary
  end

  def test_give_raise_to_department
    department = Department.new(name: "Advertising")
    don = Employee.new("Don", "don@don.com", 1231231234, 10000)
    roger = Employee.new("Roger", "roger@don.com", 1231231234, 10000)
    joan = Employee.new("Joan", "joan@don.com", 1231235555, 10000)
    don.performance(true)
    joan.performance(true)
    roger.performance(true)
    department.assign(don, roger, joan)
    department.increase(3000) {|e| e.satisfactory == true && e.name == "Roger"}
    assert_equal 13000, roger.salary
    assert_equal 33000, department.total_salary
  end

  # end

  # def test_add_employee_review
  #   assert_equal "Peggy continues to be a strong leader, creative mind, and an asset to the team.
  #    She spearheaded the Virginia Slims campaign, which was one of our biggest account of last year.
  #    She started out as a secretary and it's quite astounding to see how far she has come in
  #    a short amount of time.", Department.new("Peggy").add_reviews[:Peggy]
  # end

  # def mark_whether_employee_performing_well
  #   assert_equal "Satisfactory", Department.new("Peggy").add_reviews[:evaluation]
  # end

end
