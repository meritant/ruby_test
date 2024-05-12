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

  @color = params[:colorpicker]

  # Created hash for each param error
  hh = {username: 'Enter Name', phone: 'Enter phone', datetime: 'Enter time', dresser: 'Enter Dresser'}

  # Creating a loop

  hh.each_key do |key|
      # Checking if params[] have an empty value
      # if yes, assign error variable a message from the hash
      if params[key] == ''
        @error = hh[key]
        # And return back to same page
        return erb :visit
      end
  end


  erb "user is #{@username}, #{@phone}, #{@datetime} and #{@dresser} aand color is #{@color}"
end
