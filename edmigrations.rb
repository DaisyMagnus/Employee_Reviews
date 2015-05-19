require './employee_migration.rb'
require './department_migration.rb'


EmployeeMigration.migrate(:up)
DepartmentMigration.migrate(:up)
