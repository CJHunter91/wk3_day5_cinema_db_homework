require_relative('../db/sql_runner')

class Screening
  attr_reader :id
  attr_accessor :screening, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @screening = options['screening']
    @film_id = options['film_id']
    @limit = 3
  end

  def fully_booked?
    #check the number of tickets for the given screening and return true if fully booked
    sql = "SELECT COUNT(screenings.*) FROM screenings
    INNER JOIN tickets
    ON screenings.id = tickets.screening_id
    WHERE screening_id = #{@id};"
    (SqlRunner.run(sql)[0]['count'].to_i) + 1 >= @limit ? true : false
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

end