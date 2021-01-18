class DogsController < ApplicationController

    get '/dogs/:id' do
        #if logged in view all doctor's dogs
    end

    get '/dogs/new' do
        #if logged in, view the new dog view
        #show all shelters or option to create a new shelter
    end

    post '/dogs' do
        #create a new dog with params
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