require_relative('../db/sql_runner')
class Film
  attr_reader :id
  attr_accessor :title, :price


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save
    sql = "INSERT INTO films
     (title, price) 
     VALUES
     ('#{@title}', #{@price}) 
     RETURNING id;"
     @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def update
    sql = "UPDATE films SET
    (title, price) =
    ('#{@title}', #{@price})
    WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete
    SqlRunner.run("DELETE FROM films WHERE id = #{@id}")
  end

  def self.all
    sql = "SELECT * FROM films"
    return self.map_films(sql)
  end

  def self.delete_all
    SqlRunner.run("DELETE FROM films")
  end

  def self.map_films(sql)
    films = SqlRunner.run(sql)
    return films.map{|film| Film.new(film)}
  end


















end