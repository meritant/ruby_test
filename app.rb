require 'sinatra'
require 'rubygems'
require 'sinatra/reloader'
require 'sqlite3'



configure do
  db = SQLite3::Database.new 'BarberShop.db'
  db.execute 'CREATE TABLE IF NOT EXISTS
  "user" (
	"id"	INTEGER PRIMARY KEY AUTOINCREMENT,
	"name"	text NOT NULL DEFAULT "Noname",
	"phone"	TEXT NOT NULL,
	"date_stamp"	TEXT DEFAULT CURRENT_TIMESTAMP,
	"barber"	TEXT NOT NULL DEFAULT "no_one",
	"color"	TEXT NOT NULL DEFAULT "#ffffff"
  );'
  db.execute 'CREATE TABLE IF NOT EXISTS
  "barber" (
	"id"	INTEGER,
	"name"	TEXT NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
)'

end

get '/' do
  @message = 'Super valuable website!!!'
  erb :index
end

# Get for Visit
get '/visit' do

  # Loading list of barbers from database
  db = connect_db
  db.results_as_hash = true
  @barber_list = db.execute 'select * from barber'
  erb :visit
end

# POST for VISIT page
post '/visit' do
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

  # Inserting into table user
  # Using ???? to protect from SQL Injection
  connect_db.execute "insert into user (name, phone, date_stamp, barber, color)
values (?, ?, ?, ?, ?)", [@username, @phone, @datetime, @dresser, @color]

  erb " Thank you for register:  #{@username}, #{@phone}, #{@datetime} and #{@dresser} aand color is #{@color}"
end
# # Visit code END

# Function to connect to DB
def connect_db
  SQLite3::Database.new 'BarberShop.db'
end



# Display users from db
get '/showusers' do
  erb 'We going to show our users here'
  @db = connect_db
  @db.results_as_hash = true
  @user = @db.execute 'select * from user order by id desc'
  erb :showusers
end



#
# post '/about' do
#   require 'pony'
#   @username = params[:username]
#   @email = params[:email]
#   @message = params[:message]
#
#   hh2 = {username: 'Enter Name', email: 'Enter email', message: 'Enter message'}
#
#   hh2.each_key do |key|
#     if params[key] == ''
#       @error = hh2[key]
#       return erb :about
#     end
#   end
#
#   # Implementing pony
#
#   Pony.mail({
#               to: 'olekszhatm@gmail.com',
#               from: @email,
#               body: @message,
#               subject: @username + " has contacted you",
#               via: :smtp,
#               via_options: {
#                 address: 'smtp.gmail.com',
#                 port: '587',
#                 enable_starttls_auto: true,
#                 user_name: 'olekszhatm@gmail.com',
#                 password: '!A6b00l757',
#                 authentication: :plain, # :plain, :login, :cram_md5, no auth by default
#                 domain: "localhost.localdomain" # the HELO domain provided by the client to the server
#               }
#             })
#
#   # This is suppose to show when success
#   # redirect '/success'
#
#   # Just print out data
#   erb "username is #{@username}, #{@email} and message is #{@message}"
#
#
# end