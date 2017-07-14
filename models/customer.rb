require_relative('../db/sql_runner')
class Customer

  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end


  def save
    sql = "INSERT INTO customers
     (name, funds) 
     VALUES
     ('#{@name}', #{@funds}) 
     RETURNING id;"
     @id = SqlRunner.run(sql)[0]['id'].to_i
  end
















end