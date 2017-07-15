require_relative('../db/sql_runner')
require_relative('customer')
require_relative('screening')
require('pry')

class Film
  attr_reader :id
  attr_accessor :title, :price


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def popular_screen
    #returns most popular screening time for given film

    #get all the tickets for the given film and return a screening object for each ticket
    sql = "SELECT screenings.* FROM tickets
    INNER JOIN screenings
    ON screening_id = screenings.id
    WHERE tickets.film_id = #{@id};"
    film_screenings = Screening.map_screenings(sql)
    #iterates over film screenings and select the screening id with the most frequent time(most tickets)
    return screen_frequency(film_screenings)
  end

  def screen_frequency(array)
      #iterate through the array and create a hash with the freq of each item 
      new_hash = Hash.new(0)
      array.each{|item| new_hash[item.screening] += 1 }
      #return most freq array item
      most_frequent = new_hash.max_by{|item, freq| freq}[0]

      array.each{|item| return item if item.screening = most_frequent}
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

  def how_many_customers
    #count is postgres' built in function returns hash with 'count' => 'number' 
    sql = "SELECT count(*) FROM tickets 
        WHERE film_id = #{@id};"
    return SqlRunner.run(sql)[0]['count'].to_i
  end

  def show_customers
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON customers.id = customer_id
    WHERE film_id = #{@id};"
    return Customer.map_customers(sql)
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