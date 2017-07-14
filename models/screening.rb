require_relative('../db/sql_runner')

class Screening

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

  def delete
    SqlRunner.run("DELETE FROM screenings WHERE id = #{@id};")
  end

  def self.delete_all
    SqlRunner.run("DELETE FROM screenings;")
  end
end