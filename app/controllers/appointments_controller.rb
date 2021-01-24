class AppointmentsController < ApplicationController
    
    get '/appointments/new' do
        #if logged in view new appt page
        if session[:user_id]
            @dogs = []
            @current_doctor = Doctor.find_by(id: session[:user_id])
            @shelters = Shelter.all.select {|shelter| shelter.doctors.include?(@current_doctor)}
            @shelters.each do |shelter|
                shelter.dogs.each do |dog|
                    @dogs << dog
                end
            end
            erb :'/appointments/new'
        else
            redirect '/doctors/login'
        end
    end

    get '/appointments' do
        if session[:user_id]
            @current_doctor = Doctor.find_by(id: session[:user_id])
            redirect "/appointments/#{@current_doctor.slug}"
        else
            redirect '/doctors/login'
        end
    end

    get '/appointments/:slug' do
        #if logged in view all appts for doctor
        if session[:user_id]
            @current_doctor = Doctor.find_by_slug(params[:slug])
            @appts = DoctorDog.all.select {|appt| appt.doctor_id == session[:user_id]}
            erb :'/appointments/show'
        else
            redirect '/doctors/login'
        end

    end

    post '/appointments' do
        #creates appt with doctor_id and dog_id
        if session[:user_id]
            @current_doctor = Doctor.find_by(id: session[:user_id])
           new_appt = DoctorDog.create(doctor_id: session[:user_id], dog_id: params["appt_dog"], date: params["date"], time: params["time"])
           redirect "/appointments/#{@current_doctor.slug}"
        else
            redirect '/doctors/login'
        end
    end

    get '/appointments/:slug/edit' do
        #if logged in view the appt edit page
        if session[:user_id]
            @current_doctor = Doctor.find_by_slug(params[:slug])
            @appts = DoctorDog.all.select {|appt| appt.doctor_id == session[:user_id]}
            erb :'/appointments/edit'
        else
            redirect '/doctors/login'
        end
    end

    patch '/appointments/:slug/edit' do
        if session[:user_id]
            @current_doctor = Doctor.find_by_slug(params[:slug])
            if params["delete"]
                appt = DoctorDog.find_by(id: params["appt_id"])
                appt.destroy
                redirect "/appointments/#{@current_doctor.slug}"
            elsif params["edit"]
                new_appt = DoctorDog.find_by(id: params["appt_id"])
                new_appt.update(date: params["date"], time: params["time"])
                new_appt.save
                redirect "/appointments/#{@current_doctor.slug}"
            end
        else
            redirect '/doctors/login'
        end
    end

end