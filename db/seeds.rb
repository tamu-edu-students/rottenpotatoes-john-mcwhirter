# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Seed the RottenPotatoes DB with some movies.
more_movies = [
  {:title => 'My Neighbor Totoro', :rating => 'G',
    :release_date => '16-Apr-1988'},
  {:title => 'Green Book', :rating => 'PG-13',
    :release_date => '16-Nov-2018'},
  {:title => 'Parasite', :rating => 'R',
    :release_date => '30-May-2019'},
  {:title => 'Nomadland', :rating => 'R',
    :release_date => '19-Feb-2021'},
  {:title => 'CODA', :rating => 'PG-13',
    :release_date => '13-Aug-2021'},
  {:title => 'Everything Everywhere All at Once', :rating => 'R',
    :release_date => '25-Mar-2022'},
  {:title => 'Top Gun: Maverick', :rating => 'PG-13',
    :release_date => '27-May-2022'},
  {:title => 'The Batman', :rating => 'PG-13',
    :release_date => '04-Mar-2022'},
  {:title => 'Dune', :rating => 'PG-13',
    :release_date => '22-Oct-2021'},
  {:title => 'Spider-Man: No Way Home', :rating => 'PG-13',
    :release_date => '17-Dec-2021'}
]

more_movies.each do |movie|
  Movie.find_or_create_by(title: movie[:title]) do |m|
    m.rating = movie[:rating]
    m.release_date = movie[:release_date]
  end
end