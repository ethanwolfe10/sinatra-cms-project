class Dog < ActiveRecord::Base
    has_many :appointments
    has_many :doctors, through: :appointments
    belongs_to :breed
    belongs_to :shelter 
end
