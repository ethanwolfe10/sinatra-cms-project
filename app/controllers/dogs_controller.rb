class DogsController < ApplicationController

    get '/dogs' do
        if session[:user_id]
            @dogs = []
            @current_doctor = Doctor.find_by(id: session[:user_id])
            @shelters = Shelter.all.select {|shelter| shelter.doctors.include?(@current_doctor)}
            @shelters.each do |shelter|
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
            @dog = Dog.find_by_slug(params[:slug])
            @current_doctor = Doctor.find_by(id: session[:user_id])
            erb :'/dogs/show'
        else
            redirect '/doctors/login'
        end
    end

    post '/dogs' do
        if session[:user_id]
            current_doctor = Doctor.find_by(id: session[:user_id])
            if params["shelter"]["name"] == ""
                selected_shelter = Shelter.find_by(id: params["shelter_id"])
                if !selected_shelter.doctors.include?(current_doctor)
                    selected_shelter.doctors << current_doctor
                end          
                if params["breed_name"] == ''
                    new_dog = Dog.create(name: params["dog_name"].capitalize!, age: params["dog_age"], breed_id: params["breed_id"], shelter_id: params["shelter_id"])
                    new_dog.save
                else
                    if Breed.find_by(name: params["breed_name"])
                        #flash message with breed is aleady created
                        redirect '/dogs/new'
                    else
                        new_breed = Breed.create(name: params["breed_name"].capitalize!)
                        new_breed.save
                        new_dog = Dog.create(name: params["dog_name"].capitalize!, age: params["dog_age"], breed_id: new_breed.id, shelter_id: new_shelter.id)
                        new_dog.save
                    end
                end
            else
                if Shelter.find_by(name: params["shelter"]["name"])
                    new_shelter = Shelter.new(name: params["shelter"]["name"].capitalize!, address: params["shelter"]["address"], website: params["shelter"]["website"])
                    new_shelter.save
                    new_shelter.doctors << current_doctor
                    if params["breed_name"] == ''
                        new_dog = Dog.create(name: params["dog_name"].capitalize!, age: params["dog_age"], breed_id: params["breed_id"], shelter_id: new_shelter.id)
                        new_dog.save  
                    else
                        if Breed.find_by(name: params["breed_name"])
                            #flash message with breed is aleady created
                            redirect '/dogs/new'
                        else
                            new_breed = Breed.create(name: params["breed_name"].capitalize!)
                            new_breed.save
                            new_dog = Dog.create(name: params["dog_name"].capitalize!, age: params["dog_age"], breed_id: new_breed.id, shelter_id: new_shelter.id)
                            new_dog.save
                        end
                    end
                else
                    #flash message with shelter already exsists
                    redirect '/dogs/new'
                end 
            end
            redirect "/dogs/#{new_dog.slug}"
        else
            redirect '/doctors/login'
        end
    end

    get '/dogs/:slug/edit' do
        if session[:user_id]
            @dog = Dog.find_by_slug(params[:slug])
            @current_doctor = Doctor.find_by(id: session[:user_id])
            erb :'/dogs/edit'
        else
            redirect '/doctors/login'
        end
    end

    patch '/dogs/:slug/edit' do
        #updates dog information with params
        if session[:user_id]
            if params["delete"]
                dog = Dog.find_by(name: params["name"].downcase)
                dog.destroy
                redirect '/dogs'
            elsif params["edit"]
                new_dog = Dog.find_by(name: params["name"].downcase)
                new_dog.update(name: params["name"], shelter_id: Shelter.find_by(name: params["shelter"]).id, desc: params["desc"])
                new_dog.save
                redirect "/dogs/#{new_dog.slug}"
            end
        else
            redirect '/doctors/login'
        end
    end
end