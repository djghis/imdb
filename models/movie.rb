require_relative("../db/sql_runner")


class Movie

  attr_accessor :title, :genre, :budget
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options ['id']
    @title = options['title']
    @genre = options['genre']
    @budget = options['budget'].to_i
  end

  def save()
    sql = "INSERT INTO movies (title, genre, budget) VALUES ($1, $2, $3) RETURNING id"
    values = [@title, @genre, @budget]
    movie = SqlRunner.run(sql, values).first
    @id = movie['id'].to_i
  end

  def update()
    sql = "UPDATE movies SET (title, genre, budget) = ($1, $2, $3) WHERE id = $4"
    values = [@title, @genre, @budget, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM movies WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def stars()
    sql = "SELECT stars.* FROM stars INNER JOIN castings ON castings.star_id = stars.id WHERE movie_id = $1"
    values = [@id]
    stars = SqlRunner.run(sql, values)
    return stars.map{|star| Star.new(star)}
  end

  def remaining_budget()
    sql = "SELECT castings.fee FROM castings INNER JOIN movies ON castings.movie_id = movies.id WHERE movie_id = $1"
    values = [@id]
    fees = SqlRunner.run(sql, values)
    fees_map = fees.map{|fee_hash| fee_hash['fee'].to_i}
    fees_total = fees_map.reduce(0){|total, fee| total + fee}
    @budget -= fees_total
    return @budget
  end

  def self.all()
    sql = "SELECT * FROM movies"
    movies = SqlRunner.run(sql)
    return movies.map{|movie| Movie.new(movie)}
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    SqlRunner.run(sql)
  end


end
