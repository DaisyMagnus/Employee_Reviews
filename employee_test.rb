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
    assert_equal "Accounts", Department.new("Accounts").name
  end

  def test_create_new_employee_class
    assert Employee
  end

  def test_create_employee_given_info
    assert Employee.new(name).info
  end


  def test_add_employee_to_department
    assert Department.new(name).assign
  end

  def test_get_an_employee_name
    assert_equal "Don", Employee.new("Don").name

  end

  def test_get_department_name
    assert "Accounts", Department.name
  end

  def test_get_total_salary_for_department
     assert 500000, Department.new("Marketing").total
  end

  # def test_create_individual_employees
  #   assert_equal "Justin", Employee.new.info[:name]

  # end

  def test_get_employees_salary
    assert_equal 8000, Employee.new("Peggy").info["Peggy"][:salary]
    assert_equal 25000, Employee.new("Roger").info["Roger"][:salary]
  end

  def test_add_employee_review
    assert Department.new("Peggy").reviews[:Peggy_review]
  end

end
