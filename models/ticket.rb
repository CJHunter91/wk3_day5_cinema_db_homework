require_relative('../db/sql_runner')
class Ticket
  attr_accessor :customer_id, :film_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save
    sql = "INSERT INTO tickets
     (customer_id, film_id) 
     VALUES
     (#{@customer_id}, #{@film_id}) 
     RETURNING id;"
     @id = SqlRunner.run(sql)[0]['id'].to_i
  end



















end