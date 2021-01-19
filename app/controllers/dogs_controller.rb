class DogsController < ApplicationController

    get '/dogs/new' do
        #if logged in, view the new dog view
        #show all shelters or option to create a new shelter
        if session[:user_id]
            @current_doctor = Doctor.find_by(id: session[:user_id])
            @shelters = Shelter.all
            @breeds = Breed.all
            erb :'/dogs/new'
        else
            redirect '/doctors/login'
        end
    end

    get '/dogs/:slug' do
        if session[:user_id]
            @dog = Dog.find_by(id: params[:id])
            @current_doctor = Doctor.find_by(id: session[:user_id])
            erb :'/dogs/show'
        else
            redirect '/doctors/login'
        end
    end

    post '/dogs' do
        #create a new dog with params
        if session[:user_id]
            if !params["shelter_id"] == ''
                if !params["breed_name"].empty?
                    #need to check to see if breed is already in database before creating a new one
                    new_breed = Breed.create(name: params["breed_name"])
                    new_breed.save
                    new_dog = Dog.create(name: params["dog_name"], age: params["dog_age"], breed_id: new_breed.id, shelter_id: params["shelter_id"])
                    new_dog.save
                else
                    new_dog = Dog.create(name: params["dog_name"], age: params["dog_age"], breed_id: params["breed_id"], shelter_id: params["shelter_id"])
                    new_dog.save
                end  
            else
                #need to check to see if shelter is already in database before creating a new one
                new_shelter = Shelter.create(name: params["shelter"]["shelter_name"], website: params["shelter"]["shelter_website"], address: params["shelter"]["shelter_address"])
                new_shelter.save
                if !params["breed_name"].empty?
                    new_breed = Breed.create(name: params["breed_name"])
                    new_breed.save
                    new_dog = Dog.create(name: params["dog_name"], age: params["dog_age"], breed_id: new_breed.id, shelter_id: new_shelter.id)
                    new_dog.save
                else
                    new_dog = Dog.create(name: params["dog_name"], age: params["dog_age"], breed_id: params["breed_id"], shelter_id: new_shelter.id)
                    new_dog.save
                end 
            end
            binding.pry
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