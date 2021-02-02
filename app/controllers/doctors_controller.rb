

class DoctorsController < ApplicationController


    get "/doctors/signup" do
        if !session[:user_id]
            erb :'/doctors/create_doctor'
        else
            current_user = Doctor.find_by(id: session[:user_id])
            redirect "/doctors/#{current_user.slug}"
        end
    end

    post '/doctors/signup' do
        if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
            current_user = Doctor.create(params)
            session[:user_id] = current_user.id
            redirect "/doctors/#{current_user.slug}"
        else
            redirect '/signup'
        end
    end

    get '/doctors/login' do
        if !session[:user_id]
            erb :'/doctors/login'
        else
            current_user = Doctor.find_by(id: session[:user_id])
            redirect "/doctors/#{current_user.slug}"
        end
    end

    post '/login' do
        current_user = Doctor.find_by(username: params[:username])
        if current_user && current_user.authenticate(params[:password])
            session[:user_id] = current_user.id
            redirect "/doctors/#{current_user.slug}"
        else
            redirect '/doctors/login'
        end
    end

    get '/doctors/logout' do
        if session[:user_id]
            @current_doctor = Doctor.find_by(id: session[:user_id])
            erb :'/doctors/logout'
        else
            redirect '/doctors/login'
        end
    end

    get '/doctors/:slug/logout' do
        if session[:user_id] 
            session.clear
            redirect '/doctors/login'
        else
            redirect '/doctors/login'
        end
    end


    get '/doctors/:slug' do
        if session[:user_id]
            @dogs = []
            @current_doctor = Doctor.find_by_slug(params[:slug])
            @appts = DoctorDog.all.select {|appt| appt.doctor_id == session[:user_id]}
            @shelters = Shelter.all.select {|shelter| shelter.doctors.include?(@current_doctor)}
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
        if session[:user_id]
            @current_doctor = Doctor.find_by(id: session[:user_id])
            erb :'/doctors/new_shelter'
        else
            redirect '/doctors/login'
        end
    end

    post '/doctors/newshelter' do
        if session[:user_id]
            @current_doctor = Doctor.find_by(id: session[:user_id])
            if !Shelter.find_by(name: params["shelter"]["name"])
                new_shelter = Shelter.new(name: params["shelter"]["name"], address: params["shelter"]["address"], website: params["shelter"]["website"])
                new_shelter.save
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