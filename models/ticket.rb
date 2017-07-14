require_relative('../db/sql_runner')
require_relative('screening')
class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id'] 
    @screening_id = options['screening_id']
  end

  def save
    sql = "INSERT INTO tickets
     (customer_id, film_id, screening_id) 
     VALUES
     (#{@customer_id}, #{@film_id}, #{@screening_id}) 
     RETURNING id;"
     @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def update
    sql = "UPDATE tickets SET
    (customer_id, film_id, screening_id) =
    ('#{@customer_id}', #{@film_id}, #{@screening_id})
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete
    SqlRunner.run("DELETE FROM tickets WHERE id = #{@id}")
  end

  def self.all
    sql = "SELECT * FROM tickets"
    return self.map_tickets(sql)
  end

  def self.delete_all
    SqlRunner.run("DELETE FROM tickets")
  end

  def self.map_tickets(sql)
    tickets = SqlRunner.run(sql)
    return tickets.map{|ticket| Ticket.new(ticket)}
  end




















end