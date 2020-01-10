require 'faker'
require "cpf_cnpj"

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create user
user = User.create({email: Faker::Internet.email, password: 'demo123456'})
store = user.stores.first
account_type = user.account_types.first

# Create account
account = user.accounts.new({store: store, account_type: account_type})
# Associate person in the account
account.people.build({kind: :holder, person: Person.new({user: user, full_name: Faker::Name.name, document_number: CPF.generate(true)})})
# Create entries
account.entries.build([
  {due_date: '2020-01-08', amount: Faker::Number.decimal(l_digits: 2), kind: :debit}, 
  {due_date: '2020-01-09', amount: Faker::Number.decimal(l_digits: 2), kind: :debit}, 
  {due_date: '2020-01-10', amount: Faker::Number.decimal(l_digits: 2), kind: :debit}
])


account.save()