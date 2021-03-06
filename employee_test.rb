require 'minitest/autorun'
require 'minitest/pride'

require './employee_migration.rb'
require './department_migration.rb'
require './Employee.rb'
require './Department.rb'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'test.sqlite3'
)

ActiveRecord::Migration.verbose = false

class EmployeeTest < Minitest::Test

  def setup
    EmployeeMigration.migrate(:up)
    DepartmentMigration.migrate(:up)
  end

  def teardown
    EmployeeMigration.migrate(:down)
    DepartmentMigration.migrate(:down)
  end

  def test_department_class_exists
    department = Department.new(name: "Advertising")
    assert_equal "Advertising", department.name
  end

  def test_create_new_employee_class
    employee = Employee.new(name: "Aaron", email: "Aaron@gmail.com", phone_number: "1234567", salary: 10000)
    assert_equal "Aaron", employee.name
  end

  def test_create_employee_with_name
    don = Employee.new(name: "Don", email: "don@scdp.com", phone_number: "1231231234", salary: 10000)
    roger = Employee.new(name: "Roger", email:"roger@scdp.com", phone_number: "1231231234", salary: 10000)
    joan = Employee.new(name: "Joan", email: "joan@scdp.com", phone_number: "1231235555", salary: 10000)
    peggy = Employee.new(name: "Peggy", email: "peggy@abc.com", phone_number: "9195552222", salary: 5000)
    assert_equal "Joan", joan.name
    assert_equal "Don", don.name
    assert_equal "Peggy", peggy.name
    assert_equal 5000, peggy.salary
    assert_equal "peggy@abc.com", peggy.email
  end

  def test_add_employee_to_department
    department = Department.create(name: "Advertising")
    don = Employee.create(name: "Don", email: "don@scdp.com", phone_number: "1231231234", salary: 10000)
    department.assign(don)
    assert_equal don, department.employees.last
  end

  def test_get_total_salary_for_department
    don = Employee.new(name: "Don", email: "don@scdp.com", phone_number: "1231231234", salary: 10000)
    roger = Employee.new(name: "Roger", email:"roger@scdp.com", phone_number: "1231231234", salary: 10000)
    joan = Employee.new(name: "Joan", email: "joan@scdp.com", phone_number: "1231235555", salary: 10000)
    peggy = Employee.new(name: "Peggy", email: "peggy@abc.com", phone_number: "9195552222", salary: 5000)
    assert_equal "Joan", joan.name
    department = Department.new(name: "Advertising")
    department.assign(don)
    department.total_salary
    assert_equal 10000, department.total_salary
  end

  def test_add_text_review_to_employee
    roger = Employee.new(name: "Roger", email:"roger@scdp.com", phone_number: "1231231234", salary: 10000, reviews: "Roger has been a team player and kind soul.")
    # joan = Employee.new(name: "Joan", email: "joan@scdp.com", phone_number: "1231235555", salary: 10000)
    assert_equal "Roger has been a team player and kind soul.", roger.reviews
  end

  def test_satisfactorily_or_not
    don = Employee.new(name: "Don", email: "don@scdp.com", phone_number: "1231231234", salary: 10000, meets_standard?: true)
    # don.performance(true)
    joan = Employee.new(name: "Joan", email: "joan@scdp.com", phone_number: "1231235555", salary: 10000, meets_standard?: false)
    # joan.performance(false)
    assert_equal true, don.meets_standard?
    assert_equal false, joan.meets_standard?
  end

  def test_give_raise_to_individual
    peggy = Employee.new(name: "Peggy", email: "peggy@abc.com", phone_number: "9195552222", salary: 10000)
    peggy.bonus(0.10)
    assert_equal 11000, peggy.salary
  end

  def test_give_raise_to_department
    joan = Employee.create(name: "Joan", email: "joan@scdp.com", phone_number: "1231235555", salary: 10000, meets_standard?: true)
    peggy = Employee.create(name: "Peggy", email: "peggy@abc.com", phone_number: "9195552222", salary: 5000, meets_standard?: false)
    department = Department.create(name: "Advertising")
    department.assign(joan)
    department.assign(peggy)
    assert_equal 15000, department.total_salary
    department.increase(3000) {|e| e.meets_standard? == true}
    assert_equal 13000, joan.salary
    assert_equal 18000, department.total_salary
  end

  def test_return_the_total_number_of_employees_in_a_department
    don = Employee.new(name: "Don", email: "don@scdp.com", phone_number: "1231231234", salary: 10000)
    roger = Employee.new(name: "Roger", email:"roger@scdp.com", phone_number: "1231231234", salary: 10000)
    joan = Employee.new(name: "Joan", email: "joan@scdp.com", phone_number: "1231235555", salary: 10000)
    peggy = Employee.new(name: "Peggy", email: "peggy@abc.com", phone_number: "9195552222", salary: 5000)
    department = Department.create(name: "Advertising")
    department.assign(joan)
    department.assign(peggy)
    department.assign(don)
    department.assign(roger)
    assert_equal 4, department.employees.length
  end

  def test_return_the_employee_who_is_being_paid_the_least_in_a_department
    don = Employee.create(name: "Don", email: "don@scdp.com", phone_number: "1231231234", salary: 10000)
    roger = Employee.create(name: "Roger", email:"roger@scdp.com", phone_number: "1231231234", salary: 10000)
    joan = Employee.create(name: "Joan", email: "joan@scdp.com", phone_number: "1231235555", salary: 10000)
    peggy = Employee.create(name: "Peggy", email: "peggy@abc.com", phone_number: "9195552222", salary: 5000)
    department = Department.create(name: "Advertising")
    department.assign(joan)
    department.assign(peggy)
    department.assign(don)
    list = department.employees.order(:salary)
    assert_equal peggy, list.first
  end

  def test_return_all_employees_in_a_department_ordered_alphabetically_by_name
    don = Employee.create(name: "Don", email: "don@scdp.com", phone_number: "1231231234", salary: 10000)
    roger = Employee.create(name: "Roger", email:"roger@scdp.com", phone_number: "1231231234", salary: 10000)
    joan = Employee.create(name: "Joan", email: "joan@scdp.com", phone_number: "1231235555", salary: 10000)
    peggy = Employee.create(name: "Peggy", email: "peggy@abc.com", phone_number: "9195552222", salary: 5000)
    department = Department.create(name: "Advertising")
    department.assign(joan)
    department.assign(peggy)
    department.assign(don)
    list = department.employees.order(:name)
    assert_equal don, list.first
  end

  def test_find_employees_with_salary_below_avgerage
   don = Employee.create(name: "Don", email: "don@scdp.com", phone_number: "1231231234", salary: 10000)
   roger = Employee.create(name: "Roger", email:"roger@scdp.com", phone_number: "1231231234", salary: 10000)
   joan = Employee.create(name: "Joan", email: "joan@scdp.com", phone_number: "1231235555", salary: 10000)
   peggy = Employee.create(name: "Peggy", email: "peggy@abc.com", phone_number: "9195552222", salary: 5000)
   department = Department.create(name: "Advertising")
   department.assign(don)
   department.assign(roger)
   department.assign(joan)
   department.assign(peggy)
   assert_equal [don, roger, joan], department.employees_above_average_salary
 end

  def test_return_all_employees_with_names_which_are_palindromes
    otto = Employee.create(name: "Otto", email: "don@scdp.com", phone_number: "1231231234", salary: 10000)
    roger = Employee.create(name: "Roger", email:"roger@scdp.com", phone_number: "1231231234", salary: 10000)
    joan = Employee.create(name: "Joan", email: "joan@scdp.com", phone_number: "1231235555", salary: 10000)
    ava = Employee.create(name: "Ava", email: "peggy@abc.com", phone_number: "9195552222", salary: 5000)
    department = Department.create(name: "Advertising")
    department.assign(joan)
    department.assign(ava)
    department.assign(otto)
    assert_equal ["otto", "ava"], department.palindrome
  end

  def test_call_individual_departments
    halah = Employee.create(name: "Halah", email: "halah@scdp.com", phone_number: "1231231234", salary: 10000)
    ava = Employee.create(name: "Ava", email:"ava@scdp.com", phone_number: "1231231234", salary: 10000)
    joan = Employee.create(name: "Joan", email: "joan@scdp.com", phone_number: "1231235555", salary: 10000)
    peggy = Employee.create(name: "Peggy", email: "peggy@abc.com", phone_number: "9195552222", salary: 5000)
    advertising = Department.create(name: "Advertising")
    advertising.assign(halah)
    advertising.assign(ava)
    advertising.assign(joan)
    advertising.assign(peggy)

    don = Employee.create(name: "Don", email: "don@scdp.com", phone_number: "1231231234", salary: 10000)
    roger = Employee.create(name: "Roger", email:"roger@scdp.com", phone_number: "1231231234", salary: 10000)
    finance = Department.create(name: "Finance")
    finance.assign(don)
    finance.assign(roger)

    assert_equal ["Advertising", 4, "Finance", 2], finance.employee_count
  end
 end
