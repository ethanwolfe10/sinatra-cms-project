class DoctorsController < ApplicationController

    get '/doctors/signup' do
        #if not logged in then view signup page
        #if all params are filled then create new doctor and log them in
        #else redirect to signup or '/doctors'
        
    end

    post '/doctors/signup' do
        if !params[:username].empty? && !params[:email].empty? && !params[:password].empty?
            current_user = User.create(params)
            session[:user_id] = current_user.id
            redirect "/doctors/#{current_user.slug}"
        else
            redirect '/signup'
        end
    end

    get '/doctors/login' do
        #if not logged in then view login page
        #else redirect to '/login'
    end

    post '/login' do
        #take params check for match then log in with session[:user_id]
        #redirect to '/doctors'
    end

    get '/doctors/:slug' do
        #if logged in view all their information ie appts
    end

    get '/doctors/:slug/edit' do
        #if logged in view the edit page
        #else redirect to '/login'
    end

    patch '/doctors/:slug/edit' do
        #takes params and updates the current_doctor object
    end

    delete '/doctors/:slug/delete' do
        #deletes doctor object
    end

end