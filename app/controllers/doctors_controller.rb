class DoctorsController < ApplicationController

    get '/doctors' do
        #if signed in then view all doctors
    end

    get '/doctors/signup' do
        #if not logged in then view signup page
        #if all params are filled then create new doctor and log them in
        #else redirect to signup or '/doctors'
    end

    get '/doctors/login' do
        #if not logged in then view login page
        #else redirect to '/login'
    end

    post '/login' do
        #take params check for match then log in with session[:user_id]
        #redirect to '/doctors'
    end

    get '/doctors/:id' do
        #if logged in view all their information ie appts
    end

    get '/doctors/:id/edit' do
        #if logged in view the edit page
        #else redirect to '/login'
    end

    patch '/doctors/:id/edit' do
        #takes params and updates the current_doctor object
    end

    delete '/doctors/:id/delete' do
        #deletes doctor object
    end

end