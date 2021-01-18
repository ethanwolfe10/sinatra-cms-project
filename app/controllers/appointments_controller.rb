class AppointmentsController < ApplicationController

    get '/appointments/:id' do
        #if logged in view all appts for doctor
    end

    get '/appointments/new' do
        #if logged in view new appt page
    end

    post '/appointments' do
        #creates appt with doctor_id and dog_id
    end

    get '/appointments/:id/edit' do
        #if logged in view the appt edit page
    end

    patch '/appointments/edit' do
        #updates appointment details
    end

    delete '/appointments/delete' do
        #deletes appt
    end

end