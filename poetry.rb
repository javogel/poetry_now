require 'sinatra'
require 'httparty'
require 'sinatra/reloader'
require 'pry'

get '/hi' do


  @poem = get_poetry

  erb :home

  # @poem.to_s

end




def get_poetry
    final_poem = []
    anagram_array = "volatoris".split("")
    # poetry = HTTParty.get("http://poetrydb.org/author,linecount/Shakespeare;14/lines").to_a
    poetry = HTTParty.get("http://poetrydb.org/lines/love/author,lines,linecount").to_a
    # (0..13).each { |i| poem << poetry[rand(154)]['lines'][i] }
    poetry = poetry.shuffle
    while final_poem.length < anagram_array.length
      poetry.each do |poem|
        poem['lines'].each do |line|
            condition = (line[0] != nil) && (line[0].downcase == anagram_array[final_poem.length])


          if condition
            final_poem << line
          end

          # binding.pry

          next if condition
        end
        poetry = poetry.shuffle
      end
    end
    # (0..13).each { |i| poem << poetry[rand(154)]['lines'][i] }
    final_poem
end
