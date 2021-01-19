class DogsController < ApplicationController

    get '/dogs/:slug' do
        if session[:user_id]
            @dog = Dog.find_by(id: params[:id])
            @current_doctor = Doctor.find_by(id: session[:user_id])
            erb :'/dogs/show'
        else
            redirect '/doctors/login'
        end
    end

    get '/dogs/new' do
        #if logged in, view the new dog view
        #show all shelters or option to create a new shelter
        if session[:user_id]
            @current_doctor = Doctor.find_by(id: session[:user_id])
            erb :'/dogs/new'
        else
            redirect '/doctors/login'
        end
    end

    post '/dogs' do
        #create a new dog with params
        if session[:user_id]
            @new_dog = Dog.create(params)
            @new_dog.doctor_ids << Doctor.find_by(id: session[:user_id])
            redirect "/dogs/#{@new_dog.slug}"
        else
            redirect '/doctors/login'
        end
    end

    get '/dogs/:id/edit' do
        #edits dogs that belong to doctor
    end

    post '/dogs/edit' do
        #updates dog information with params
    end

    delete '/dogs/delete' do
        #deletes dog object
    end
end