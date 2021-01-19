

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
            erb :'/doctors/logout'
        end
    end

    post '/logout' do
        if session[:user_id] 
            session.clear
            redirect '/doctors/login'
        else
            redirect '/doctors/login'
        end
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