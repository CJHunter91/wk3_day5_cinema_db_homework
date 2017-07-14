require_relative('../models/customer')
require_relative('../models/ticket')
require_relative('../models/film')
require('pry')

customer_chris = Customer.new({"name" => "Chris", "funds" => 100})
customer_chris.save

customer2 = Customer.new({"name" => "Rick", "funds" => 50})
customer2.save



raiders = Film.new({"title" => "Raiders of the lost ark", "price" => 13})
raiders.save

c_ticket_raiders = Ticket.new({"customer_id" =>customer_chris.id, "film_id" => raiders.id})
c_ticket_raiders.save

customer2.name = "John"
customer2.update
binding.pry
nil