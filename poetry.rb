require 'sinatra'
# require 'sinatra/reloader'
require 'httparty'
require 'gon-sinatra'

Sinatra.register Gon::Sinatra

get '/' do
  @poem = get_poetry
  erb :home
end

get '/infinite' do
  all_starting_lines = next_two_hundred

  @poem = all_starting_lines.slice!(0, 35)
  gon.starting_buffer_of_poetry = all_starting_lines

  erb :infinite
end

get '/gimme_random' do
  @poem = { data: next_two_hundred }
  @poem.to_json
end

get '/favicon.ico' do
  
end

get '/:id' do
  @poem = get_poetry(params[:id])
  @acrostic = params[:id]

  erb :home

end

def get_poetry(acrostic = 'volatoris')
  final_poem = []
  acrostic_array = acrostic.downcase.split('')
  # poetry = HTTParty.get("http://poetrydb.org/author,linecount/Shakespeare;14/lines").to_a
  poetry = HTTParty.get('http://poetrydb.org/lines/love/author,lines').to_a
  # (0..13).each { |i| poem << poetry[rand(154)]['lines'][i] }
  poetry = poetry.shuffle
  while final_poem.length < acrostic_array.length
    poem = poetry.sample
    candidate_lines = poem['lines'].select do |line|
      line.strip.downcase[0] == acrostic_array[final_poem.length]
    end
    puts "looking for verse starting with #{acrostic_array[final_poem.length]}"
    final_poem << [candidate_lines.sample.strip, poem['author']] unless candidate_lines.empty?
  end
  final_poem
end

def next_two_hundred
  final_poem = []
  poetry = HTTParty.get('http://poetrydb.org/lines/love/author,lines,linecount').to_a
  poetry = poetry.shuffle

  200.times do |_x|
    final_poem << poetry.sample['lines'].sample
  end

  final_poem
end
