class Shelter < ActiveRecord::Base
    has_many :doctor_shelters
    has_many :doctors, through: :doctor_shelters
    has_many :dogs
end
