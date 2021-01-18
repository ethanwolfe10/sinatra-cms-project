class CreateDogs < ActiveRecord::Migration
    def change
        create_table :dogs do |t|
            t.string :name
            t.integer :age
            t.integer :breed_id
            t.integer :shelter_id
        end
    end
end