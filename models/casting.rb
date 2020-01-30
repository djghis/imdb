require_relative("../db/sql_runner")

class Casting

    attr_reader :id, :movie_id, :star_id, :fee

    def initialize(options)
      @id = options['id'].to_i if options ['id']
      @movie_id = options['movie_id']
      @star_id = options['star_id']
      @fee = options['fee'].to_i
    end

    def save()
      sql = "INSERT INTO castings (movie_id, star_id, fee) VALUES ($1, $2, $3) RETURNING id"
      values = [@movie_id, @star_id, @fee]
      casting = SqlRunner.run(sql, values).first
      @id = casting['id'].to_i
    end

    def update()
      sql = "UPDATE castings SET (casting_id, star_id) = ($1, $2, $3) WHERE id = $4"
      values = [@movie_id, @star_id, @fee, @id]
      SqlRunner.run(sql, values)
    end

    def delete()
      sql = "DELETE FROM castings WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def self.all()
      sql = "SELECT * FROM castings"
      castings = SqlRunner.run(sql)
      return castings.map{|casting| Casting.new(casting)}
    end

    def self.delete_all()
      sql = "DELETE FROM castings"
      SqlRunner.run(sql)
    end


end
