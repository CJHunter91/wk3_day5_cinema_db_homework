require_relative('../db/sql_runner')
class Film

  def initialize(options)
    @id = options['id'] if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save
    sql = "INSERT INTO films
     (title, price) 
     VALUES
     ('#{@title}', #{@price}) 
     RETURNING id;"
     @id = SqlRunner.run(sql)[0]['id']
  end


















end