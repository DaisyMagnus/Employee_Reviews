require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db.sqlite3'
)

class DepartmentMigration < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.timestamp null: false
    end
  end
end
