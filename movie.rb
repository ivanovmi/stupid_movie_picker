require 'sequel'
require 'kp_api'
require 'pp'
class Database
  DB = Sequel.connect('sqlite://movie.db')
  def initialize
    DB.create_table? :movies do
      primary_key :id
      String :name
      String :link
      String :poster
      String :poster_big
    end
    movies = DB[:movies]
    movies_list = Array.new
    File.foreach('movies_list.txt') do |line|
      l = line.strip
      p l
      if l.start_with?('#')
        next
      end
      # let's assume that our film is always first
      movie = KpApi::FilmSearch.new(l).view[0]
      movies_list.push({id: "#{movie[:id]}",
                        name: "#{movie[:name_ru]}",
                        link: "https://www.kinopoisk.ru/film/#{movie[:id]}/",
                        poster: "#{movie[:poster_url]}",
                        poster_big: "https://st.kp.yandex.net/images/film_big/#{movie[:id]}.jpg"})
    end
    movies.insert_ignore.multi_insert(movies_list)
  end
end


class Movie
  DB = Sequel.connect('sqlite://movie.db')
  def get_random_movie
    movies = DB[:movies]
    movies.order(Sequel.lit('RANDOM()')).last
  end
end
