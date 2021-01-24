require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #create new shelterdoctor join table
  #change how new dogs get created by doctor
  #list dogs available for appt through new join table
  #create new appt with doctordog
  

  get "/" do
    erb :welcome
  end

end
