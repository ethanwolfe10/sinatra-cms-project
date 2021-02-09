class AppointmentsController < ApplicationController
    
    get '/appointments/new' do
        #if logged in view new appt page
        if Helpers.is_logged_in?(session)
            @dogs = []
            current_doctor(session)
            @shelters = @current_doctor.shelters
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
        if Helpers.is_logged_in?(session)
            current_doctor(session)
            redirect "/appointments/#{@current_doctor.slug}"
        else
            redirect '/doctors/login'
        end
    end

    get '/appointments/:slug' do
        #if logged in view all appts for doctor
        if Helpers.is_logged_in?(session)
            current_doctor(session)
            @appts = @current_doctor.doctor_dogs
            erb :'/appointments/show'
        else
            redirect '/doctors/login'
        end

    end

    post '/appointments' do
        #creates appt with doctor_id and dog_id
        if Helpers.is_logged_in?(session)
            current_doctor(session)
            if params["appt_dog"] && params["date"] && params["time"]
                new_appt = DoctorDog.create(doctor_id: @current_doctor.id, dog_id: params["appt_dog"], date: params["date"], time: params["time"])
                redirect "/appointments/#{@current_doctor.slug}"
            else
                redirect '/appointments/new'
            end
        else
            redirect '/doctors/login'
        end
    end

    get '/appointments/:slug/edit' do
        #if logged in view the appt edit page
        if Helpers.is_logged_in?(session)
            current_doctor(session)
            @appts = @current_doctor.doctor_dogs
            erb :'/appointments/edit'
        else
            redirect '/doctors/login'
        end
    end

    patch '/appointments/:slug/edit' do
        if Helpers.is_logged_in?(session)
            
            current_doctor(session)
            if params["delete"]
                appt = DoctorDog.find_by(id: params["appt_id"])
                if appt.doctor_id == @current_doctor.id
                    appt.destroy
                end
                redirect "/appointments/#{@current_doctor.slug}"
            elsif params["edit"]
                new_appt = DoctorDog.find_by(id: params["appt_id"])
                if new_appt.doctor_id == @current_doctor.id
                    new_appt.update(date: params["date"], time: params["time"])
                end
                redirect "/appointments/#{@current_doctor.slug}"
            end
        else
            redirect '/doctors/login'
        end
    end

end