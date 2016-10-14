require 'sinatra'
# require 'sinatra/reloader'
require 'httparty'
require 'gon-sinatra'
# require 'pry'

Sinatra::register Gon::Sinatra


get '/' do

  @poem = get_poetry
  erb :home

end

get '/infinite' do
  all_starting_lines = starting_random_poem

  @poem = all_starting_lines.slice!(0,15)
  gon.starting_buffer_of_poetry = all_starting_lines

  erb :infinite

end

get '/gimme_random' do

  @poem = {data: next_two_hundred}
  @poem.to_json

end

get '/:id' do


  @poem = get_poetry(params[:id])
  @acrostic = params[:id]

  erb :home

  # @poem.to_s

end




def get_poetry(acrostic = "volatoris")
    final_poem = []
    acrostic_array = acrostic.split("")
    # poetry = HTTParty.get("http://poetrydb.org/author,linecount/Shakespeare;14/lines").to_a
    poetry = HTTParty.get("http://poetrydb.org/lines/love/author,lines,linecount").to_a
    # (0..13).each { |i| poem << poetry[rand(154)]['lines'][i] }
    poetry = poetry.shuffle
    while final_poem.length < acrostic_array.length
      poetry.each do |poem|
        poem['lines'].each do |line|
            condition = (line[0] != nil) && (line[0].downcase == acrostic_array[final_poem.length])
          if condition
            final_poem << [line, poem['author']]
          end
          next if condition
        end
        poetry = poetry.shuffle
      end
    end
    # (0..13).each { |i| poem << poetry[rand(154)]['lines'][i] }
    final_poem
end



def starting_random_poem
    final_poem = []

    # poetry = HTTParty.get("http://poetrydb.org/author,linecount/Shakespeare;14/lines").to_a
    poetry = HTTParty.get("http://poetrydb.org/lines/life/author,lines,linecount").to_a
    poetry = poetry.shuffle

      # binding.pry
      200.times do |x|
            final_poem << poetry.sample["lines"].sample
      end

    final_poem
end


def next_two_hundred
    final_poem = []

    # poetry = HTTParty.get("http://poetrydb.org/author,linecount/Shakespeare;14/lines").to_a
    poetry = HTTParty.get("http://poetrydb.org/lines/love/author,lines,linecount").to_a
    poetry = poetry.shuffle

      # binding.pry
      200.times do |x|
            final_poem << poetry.sample["lines"].sample
      end

    final_poem
end
