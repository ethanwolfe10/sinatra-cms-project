class DogsController < ApplicationController

    get '/dogs' do
        if Helpers.is_logged_in?(session)
            #Refactor these
            @dogs = []
            current_doctor(session)
            @current_doctor.shelters.each do |shelter|
                shelter.dogs.each do |dog|
                    @dogs << dog
                end
            end
            erb :'/dogs/index'
        else
            redirect '/doctors/login'
        end
    end

    get '/dogs/new' do
        if Helpers.is_logged_in?(session)
            current_doctor(session)
            if !@current_doctor.shelters.empty?
                @shelters = @current_doctor.shelters
                @breeds = Breed.all
                erb :'/dogs/new'
            else
                redirect "/doctors/#{@current_doctor.slug}/newshelter"               
            end
        else
            redirect '/doctors/login'
        end
    end

    get '/dogs/:slug' do
        if Helpers.is_logged_in?(session)
            current_doctor(session)
            @dog = Dog.find_by_slug(params[:slug])         
            erb :'/dogs/show'
        else
            redirect '/doctors/login'
        end
    end

    post '/dogs' do
        if Helpers.is_logged_in?(session)
            if params["dog_name"] && params["shelter_id"] && params["dog_age"]
                new_dog_name = params["dog_name"].capitalize
                current_doctor(session)
                selected_shelter = Shelter.find_by(id: params["shelter_id"])        
                if params["breed_name"] == ''
                    new_dog = Dog.create(name: new_dog_name, age: params["dog_age"], breed_id: params["breed_id"], shelter_id: params["shelter_id"])
                else
                    if !Breed.find_by(name: params["breed_name"]) 
                        new_breed = Breed.create(name: params["breed_name"].capitalize)
                        new_dog = Dog.create(name: new_dog_name, age: params["dog_age"], breed_id: new_breed.id, shelter_id: params["shelter_id"])
                    else
                        redirect '/dogs/new'
                    end
                end
                redirect "/dogs/#{new_dog.slug}"
            end
        else
            redirect '/doctors/login'
        end
    end

    get '/dogs/:slug/edit' do
        if Helpers.is_logged_in?(session)
            @dog = Dog.find_by_slug(params[:slug])
            current_doctor(session)
            erb :'/dogs/edit'
        else
            redirect '/doctors/login'
        end
    end

    patch '/dogs/:slug/edit' do
        #updates dog information with params
        if Helpers.is_logged_in?(session)
            if params["delete"]
                dog = Dog.find_by_slug(params[:slug])
                dog.destroy
                redirect '/dogs'
            elsif params["edit"]
                new_dog = Dog.find_by_slug(params[:slug])
                new_dog.update(name: params["name"], shelter_id: Shelter.find_by(name: params["shelter"]).id, desc: params["desc"])
                redirect "/dogs/#{new_dog.slug}"
            end
        else
            redirect '/doctors/login'
        end
    end
end