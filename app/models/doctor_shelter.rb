class DoctorShelter < ActiveRecord::Base
    belongs_to :doctor
    belongs_to :shelter
end