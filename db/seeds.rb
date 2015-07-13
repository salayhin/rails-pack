# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



['superAdmin', 'member'].each do |role|
  Role.first_or_create({ name: role })
end

user = User.new
user.email = 'admin@example.com'
user.password = 'password'
user.password_confirmation = 'password'

if user.save
  role_user = RolesUsers.find_by_user_id(user.id)
  role_user.role_id = Role::USER_ROLE[:super_admin]
  role_user.save
end

