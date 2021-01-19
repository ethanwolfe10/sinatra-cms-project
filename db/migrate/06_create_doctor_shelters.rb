class CreateDoctorShelters < ActiveRecord::Migration
    def change
        create_table :doctor_shelters do |t|
            t.integer :shelter_id
            t.integer :doctor_id
        end
    end
end