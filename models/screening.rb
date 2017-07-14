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
    return SqlRunner.run(sql)[0]['id']
  end

end