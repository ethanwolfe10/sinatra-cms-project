class DogsController < ApplicationController

    get '/dogs' do
        if session[:user_id]
            @current_doctor = Doctor.find_by(id: session[:user_id])
            @dogs = []
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
            binding.pry
            @dog = Dog.find_by_slug(params[:slug])
            @current_doctor = Doctor.find_by(id: session[:user_id])
            erb :'/dogs/show'
        else
            redirect '/doctors/login'
        end
    end

    # post '/dogs' do
    #     current_doctor = Doctor.find_by(id: session[:user_id])
    #     if session[:user_id]
    #         if params["shelter"]["shelter_name"] == ''
    #             #need to check to see if shelter is already in database before creating a new one
    #             new_shelter = Shelter.create(name: params["shelter"]["shelter_name"], website: params["shelter"]["shelter_website"], address: params["shelter"]["shelter_address"])
    #             new_shelter.save
    #             new_shelter.doctors << current_doctor
    #             if !params["breed_name"] == ''
    #                 #need to check to see if breed is already in database before creating a new one
    #                binding.pry
    #                 new_breed = Breed.create(name: params["breed_name"])
    #                 new_breed.save
    #                 new_dog = Dog.create(name: params["dog_name"], age: params["dog_age"], breed_id: new_breed.id, shelter_id: new_shelter.id)
    #                 new_dog.save
    #             else
    #                 binding.pry
    #                 new_dog = Dog.create(name: params["dog_name"], age: params["dog_age"], breed_id: params["breed_id"], shelter_id: new_shelter.id)
    #                 new_dog.save
    #             end  
    #         else
    #             selected_shelter = Shelter.find_by(id: params["shelter_id"])
    #             if !selected_shelter.doctors.include?(current_doctor)
    #                 selected_shelter.doctors << current_doctor
    #             end          
    #             if !params["breed_name"] == ''
    #                 binding.pry
    #                 new_breed = Breed.create(name: params["breed_name"])
    #                 new_breed.save
    #                 new_dog = Dog.create(name: params["dog_name"], age: params["dog_age"], breed_id: new_breed.id, shelter_id: params["shelter_id"])
    #                 new_dog.save
    #             else
    #                 binding.pry
    #                 new_dog = Dog.create(name: params["dog_name"], age: params["dog_age"], breed_id: params["breed_id"], shelter_id: params["shelter_id"])
    #                 new_dog.save
    #             end 
    #         end
    #         redirect "/dogs/#{new_dog.slug}"
    #     else
    #         redirect '/doctors/login'
    #     end
    # end

    post '/dogs' do
        if session[:user_id]
            current_doctor = Doctor.find_by(id: session[:user_id])
            if params["shelter"]["shelter_name"] == ""
                binding.pry
                selected_shelter = Shelter.find_by(id: params["shelter_id"])
                if !selected_shelter.doctors.include?(current_doctor)
                    binding.pry
                    selected_shelter.doctors << current_doctor
                end          
                if params["breed_name"] == ''
                    binding.pry
                    new_dog = Dog.create(name: params["dog_name"], age: params["dog_age"], breed_id: params["breed_id"], shelter_id: params["shelter_id"])
                    new_dog.save
                else
                    binding.pry
                    new_breed = Breed.create(name: params["breed_name"])
                    new_breed.save
                    new_dog = Dog.create(name: params["dog_name"], age: params["dog_age"], breed_id: new_breed.id, shelter_id: params["shelter_id"])
                    new_dog.save
                end
            else
                binding.pry
                new_shelter = Shelter.create(params["shelter"])
                new_shelter.save
                new_shelter.doctors << current_doctor
                if params["breed_name"] == ''
                    #need to check to see if breed is already in database before creating a new one
                   new_dog = Dog.create(name: params["dog_name"], age: params["dog_age"], breed_id: params["breed_id"], shelter_id: new_shelter.id)
                    new_dog.save  
                else
                    new_breed = Breed.create(name: params["breed_name"])
                    new_breed.save
                    new_dog = Dog.create(name: params["dog_name"], age: params["dog_age"], breed_id: new_breed.id, shelter_id: new_shelter.id)
                    new_dog.save
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