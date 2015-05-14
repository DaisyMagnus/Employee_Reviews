require 'minitest/autorun'
require 'minitest/pride'

require './Employee.rb'
require './Department.rb'

class EmployeeTest < Minitest::Test

  def test_department_class_exists
    assert Department
  end

  def test_create_new_department_given_name
    assert_equal "Accounts", Department.new("Accounts").name
  end

  def test_create_new_employee
    assert Employee
  end
end
