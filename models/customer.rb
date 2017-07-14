require_relative('../db/sql_runner')
class Customer

  def initialize(options)
    @id = options['id'] if options['id']
    @name = options['name']
    @funds = options['funds']
  end


  def save
    sql = "INSERT INTO customers
     (name, funds) 
     VALUES
     ('#{@name}', #{@funds}) 
     RETURNING id;"
     @id = SqlRunner.run(sql)[0]['id']
  end
















end