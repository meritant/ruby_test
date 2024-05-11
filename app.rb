require 'sinatra'
require 'rubygems'
require 'sinatra/reloader'

get '/' do
  @message = 'Super valuable website!!!'
  erb :index
end

get '/about' do
  erb :about
end

get '/wealth' do
  erb :wealth
end

get '/visit' do
  erb :visit
end

post '/visit' do
  erb 'Success'
  @username = params[:username]
  @phone = params[:phone]
  @datetime = params[:datetime]
  @dresser = params[:dresser]

  erb "user is #{@username}, #{@phone}, #{@datetime} and #{@dresser}"


end