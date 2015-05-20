require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db.sqlite3'
)


class Employee <ActiveRecord::Base
  belongs_to :department
  def bonus(percent)
    self.salary += (salary * percent)
  end

  

end
