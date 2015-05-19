require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db.sqlite3'
)


class Employee <ActiveRecord::Base
  # attr_reader :name, :email, :phone_number, :reviews, :satisfactory
  # attr_accessor :salary
  belongs_to :department
def add_review(review)
  reviews
end

def performance(value)
  satisfactory = value
end

def bonus(percent)
  salary = (salary * percent) + salary
end

def parse_review
   !(@reviews.include?("but"))
end


end
