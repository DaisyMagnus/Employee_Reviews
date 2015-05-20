require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db.sqlite3'
)

class EmployeeMigration < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.float :salary, precision: 2, scale: 8
      t.text    :reviews
      t.boolean :meets_standard?
      t.references :department
      t.timestamp null: false
    end
  end
end
