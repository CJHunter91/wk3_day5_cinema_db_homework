require_relative('../db/sql_runner')
class Ticket

  def initialize(options)
    @id = options['id'] if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end



















end