class Department < Employee
  def initialize(name)
    @name = name
    @department = []
    @employee = {:Draper => 150000, :Sterling => 200000, :Cooper => 100000, :Price => 750000}
    @reviews = {:Peggy_review => "Peggy continues to be a strong leader, creative mind, and an asset to the team.
     She spearheaded the Virginia Slims campaign, which was one of our biggest account of last year.
     She started out as a secretary and it's quite astounding to see how far she has come in
     a short amount of time."}
  end

  def name
    @name
  end

  def assign
    @department << @employee
  end

  def total
    total = []
    @employee.to_a.each {|y| total << y}
      p total
  end

  def reviews
    @reviews
  end


end
