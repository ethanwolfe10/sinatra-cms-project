class AppointmentsController < ApplicationController
    
    get '/appointments/new' do
        #if logged in view new appt page
        if session[:user_id]
            @dogs = []
            @current_doctor = Doctor.find_by(id: session[:user_id])
            @shelters = Shelter.all.select {|shelter| shelter.doctors.include?(@current_doctor)}
            @shelters.each do |shelter|
                @dogs = shelter.dogs
            end
            erb :'/appointments/new'
        else
            redirect '/doctors/login'
        end
    end

    get '/appointments/:slug' do
        #if logged in view all appts for doctor
        if session[:user_id]
            @current_doctor = Doctor.find_by_slug(params[:slug])
            
        end
    end

    post '/appointments' do
        #creates appt with doctor_id and dog_id
        if session[:user_id]
            @current_doctor = Doctor.find_by(id: session[:user_id])
           new_appt = DoctorDog.create(doctor_id: session[:user_id], dog_id: params["appt_dog"], date: params["date"], time: params["time"])
           binding.pry
           redirect "/appointments/#{@current_doctor.slug}"
        else
            redirect '/doctors/login'
        end
    end

    get '/appointments/:slug/edit' do
        #if logged in view the appt edit page
    end

    patch '/appointments/edit' do
        #updates appointment details
    end

    delete '/appointments/delete' do
        #deletes appt
    end

end