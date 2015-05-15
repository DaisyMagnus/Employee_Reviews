class Employee
def initialize(name)
  @name = name
  @info = {}
  #for @info.each do |name, salary| puts name, salary end
end

def info
   @info = {"Peggy"=>{:name => name, :salary => 80000, :phone => 9193567878, :email => "peggy@scdp.com"}}
end

def name
  @name
end

end
