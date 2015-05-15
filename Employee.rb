class Employee
def initialize(name)
  @name = name
  @info = {}
  #for @info.each do |name, salary| puts name, salary end
end

def info
   @info = {"Peggy"=>{:name => name, :salary => 8000, :phone => 9193567878, :email => "peggy@scdp.com"},
            "Don"=>{:name => name, :salary => 20000, :phone => 9193569999, :email => "dondraper@scdp.com"},
            "Roger"=>{:salary => 25000, :phone => 9195556677, :email => "rogersterling@scdp.com"},
            "Joan"=>{:salary => 15000, :phone => 9199192222, :email => "joanie@scdp.com"}}

end

def name
  @name
end

end
