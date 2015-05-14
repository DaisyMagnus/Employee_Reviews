class Department
  def initialize(name)
    @name = name
    @department = []
    @employee = {}
  end

  def name
    @name
  end

  def assign
    @department << @employee
  end

end
