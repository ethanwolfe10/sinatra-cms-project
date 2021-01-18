class DoctorDog < ActiveRecord::Base
    belongs_to :doctor 
    belongs_to :dog 
end
