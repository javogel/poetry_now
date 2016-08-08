require 'sinatra'
require 'httparty'
require 'sinatra/reloader'

get '/hi' do


  @poem = get_poetry

  erb :home

end




def get_poetry
    poem = []
    poetry = HTTParty.get("http://poetrydb.org/author,linecount/Shakespeare;14/lines").to_a
    (0..13).each { |i| poem << poetry[rand(154)]['lines'][i] }
    poem
end
