require_relative('models/star')
require_relative('models/movie')
require_relative('models/casting')

require('pry')

Casting.delete_all()
Star.delete_all()
Movie.delete_all()

star1 = Star.new({'first_name' => 'Lindsay', 'last_name' => 'Lohan'})
star1.save()

star2 = Star.new({'first_name' => 'Tina', 'last_name' => 'Fey'})
star2.save()

movie1 = Movie.new({'title' => 'Mean Girls', 'genre' => 'chick flick', 'budget' => '2000000'})
movie1.save()

movie2 = Movie.new({'title' => 'Parent Trap', 'genre' => 'children\'s movie', 'budget' => '2000000'})
movie2.save()

casting1 = Casting.new({'movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => '300000'})
casting2 = Casting.new({'movie_id' => movie2.id, 'star_id' => star1.id, 'fee' => '1000000'})
casting3 = Casting.new({'movie_id' => movie1.id, 'star_id' => star2.id, 'fee' => '700000'})
casting1.save()
casting2.save()
casting3.save()


binding.pry
nil
