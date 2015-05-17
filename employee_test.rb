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
    roger = Employee.new("Roger", "roger@scdp.com", 1231231234, 10000)
    joan = Employee.new("Joan", "joan@scdp.com", 1231235555, 10000)
    peggy = Employee.new("Peggy", "peggy@abc.com", 9195552222, 5000)
    assert_equal "Joan", joan.name
    assert_equal "Don", don.name
    assert_equal "Peggy", peggy.name
    assert_equal "peggy@abc.com", peggy.email
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
    don = Employee.new("Don", "don@don.com", 1231231234, 10000)
    don.add_review("Don is a very positive person and encourages those around him, but he has not done well technically this year.  There are two areas in which Don has room for improvement.  First, when communicating verbally (and sometimes in writing), he has a tendency to use more words than are required.  This conversational style does put people at ease, which is valuable, but it often makes the meaning difficult to isolate, and can cause confusion.
    Second, when discussing new requirements with project managers, less of the information is retained by Don long-term than is expected.  This has a few negative consequences: 1) time is spent developing features that are not useful and need to be re-run, 2) bugs are introduced in the code and not caught because the tests lack the same information, and 3) clients are told that certain features are complete when they are inadequate.  This communication limitation could be the fault of project management, but given that other developers appear to retain more information, this is worth discussing further.")
    roger = Employee.new("Roger", "roger@scdp.com", 1231235557, 10000)
    roger.add_review("Roger has been a team player and kind soul.")
    assert_equal "Roger has been a team player and kind soul.", roger.reviews[0]
    joan = Employee.new("Joan", "joan@don.com", 1231235555, 10000)
    joan.add_review("Joan has been an incredibly consistent and effective developer.  Clients are always satisfied with her work, developers are impressed with her productivity, and she's more than willing to help others even when she has a substantial workload of her own.  She is a great asset to Awesome Company, and everyone enjoys working with her.  During the past year, she has largely been devoted to work with the Cement Company, and she is the perfect woman for the job.  We know that work on a single project can become monotonous, however, so over the next few months, we hope to spread some of the Cement Company work to others.  This will also allow Joan to pair more with others and spread her effectiveness to other projects.
      ")
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
    joan = Employee.new("Joan", "joan@don.com", 1231235555, 8000)
    don.performance(true)
    joan.performance(true)
    roger.performance(true)
    department.assign(don, roger, joan)
    department.increase(3000) {|e| e.satisfactory == true && e.name == "Roger"}
    assert_equal 13000, roger.salary
    assert_equal 31000, department.total_salary
  end

  def test_parse_employee_review
    don = Employee.new("Don", "don@don.com", 1231231234, 10000)
    don.add_review("Don is a very positive person and encourages those around him, but he has not done well technically this year.  There are two areas in which Don has room for improvement.  First, when communicating verbally (and sometimes in writing), he has a tendency to use more words than are required.  This conversational style does put people at ease, which is valuable, but it often makes the meaning difficult to isolate, and can cause confusion.
    Second, when discussing new requirements with project managers, less of the information is retained by Don long-term than is expected.  This has a few negative consequences: 1) time is spent developing features that are not useful and need to be re-run, 2) bugs are introduced in the code and not caught because the tests lack the same information, and 3) clients are told that certain features are complete when they are inadequate.  This communication limitation could be the fault of project management, but given that other developers appear to retain more information, this is worth discussing further.")
    don.parse_review
    assert_equal false, don.parse_review

  end

end
