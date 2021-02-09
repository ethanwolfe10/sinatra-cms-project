

class DoctorsController < ApplicationController


    get "/doctors/signup" do
        if Helpers.is_logged_in?(session)
            current_doctor(session)
            redirect "/doctors/#{@current_doctor.slug}"
        else           
            erb :'/doctors/create_doctor'
        end
    end

    post '/doctors/signup' do
        if !params[:username].empty? && !params[:password].empty?
            if !Doctor.find_by(username: params[:username])
                @current_doctor = Doctor.create(params)
                session[:user_id] = @current_doctor.id
                redirect "/doctors/#{@current_doctor.slug}"          
            end
        end
        redirect '/doctors/signup'
    end

    get '/doctors/login' do
        if Helpers.is_logged_in?(session)
            current_doctor(session)
            redirect "/doctors/#{@current_doctor.slug}"
        else
            erb :'/doctors/login'
        end
    end

    post '/login' do
        @current_doctor = Doctor.find_by(username: params[:username])
        if @current_doctor && @current_doctor.authenticate(params[:password])
            session[:user_id] = @current_doctor.id
            redirect "/doctors/#{@current_doctor.slug}"
        else
            redirect '/doctors/login'
        end
    end

    get '/doctors/logout' do
        if Helpers.is_logged_in?(session)
            current_doctor(session)
            erb :'/doctors/logout'
        else
            redirect '/doctors/login'
        end
    end

    get '/doctors/:slug/logout' do
        if Helpers.is_logged_in?(session) 
            session.clear
            redirect '/doctors/login'
        else
            redirect '/doctors/login'
        end
    end


    get '/doctors/:slug' do
        if Helpers.is_logged_in?(session)
            @dogs = []
            current_doctor(session)
            @appts = @current_doctor.doctor_dogs
            @shelters = @current_doctor.shelters
            @shelters.each do |shelter|
                shelter.dogs.each do |dog|
                    @dogs << dog
                end
            end
            erb :'/doctors/show'
        else
            redirect '/doctors/login'
        end
    end

    get '/doctors/:slug/newshelter' do
        if Helpers.is_logged_in?(session)
            current_doctor(session)
            erb :'/doctors/new_shelter'
        else
            redirect '/doctors/login'
        end
    end

    post '/doctors/newshelter' do
        if Helpers.is_logged_in?(session)
            current_doctor(session)
            if !Shelter.find_by(name: params["shelter"]["name"])
                new_shelter = Shelter.create(name: params["shelter"]["name"], address: params["shelter"]["address"], website: params["shelter"]["website"])
                new_shelter.doctors << @current_doctor
                redirect '/dogs/new'
            else
                redirect '/doctors/newshelter'
            end
        else
            redirect '/doctors/login'
        end
    end    


end