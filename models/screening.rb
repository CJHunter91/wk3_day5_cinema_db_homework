require_relative('../db/sql_runner')

class Screening
  attr_reader :id
  attr_accessor :screening, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @screening = options['screening']
    @film_id = options['film_id']
  end

  def save
    sql = "INSERT INTO screenings 
    (screening, film_id)
    VALUES
    ('#{@screening}', #{@film_id})
    RETURNING id;"
    @id = SqlRunner.run(sql)[0]['id'].to_i 
  end


  def update
    sql = "UPDATE screenings SET
    (screening, film_id) =
    ('#{@screening}', #{@film_id})
    WHERE 
    id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete
    SqlRunner.run("DELETE FROM screenings WHERE id = #{@id};")
  end

  def self.popular_screen(film)
    #returns most popular screening time for given film

    #get all the tickets for the given film and return a screening object for each ticket
    sql = "SELECT screenings.* FROM tickets
    INNER JOIN screenings
    ON screening_id = screenings.id
    WHERE tickets.film_id = #{film.id};"
    film_screenings = Screening.map_screenings(sql)
    #iterates over film screenings and select the screening id with the most frequent time(most tickets)
    return self.screen_frequency(film_screenings)
  end

  def self.all
    sql = "SELECT * FROM screenings"
    return self.map_screenings(sql)
  end

  def self.delete_all
    SqlRunner.run("DELETE FROM screenings;")
  end

  def self.map_screenings(sql)
    return SqlRunner.run(sql).map{|screening| Screening.new(screening)}
  end

  def self.screen_frequency(array)
    #iterate through the array and create a hash with the freq of each item 
    new_hash = Hash.new(0)
    array.each{|item| new_hash[item.screening] += 1 }
    #return most freq array item
    most_frequent = new_hash.max_by{|item, freq| freq}[0]

    array.each{|item| return item if item.screening = most_frequent}
  end
end