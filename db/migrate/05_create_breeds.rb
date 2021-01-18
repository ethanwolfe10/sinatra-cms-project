class CreateBreeds < ActiveRecord::Migration
    def change
        create_table :breeds do |t|
            t.string :name
        end
    end
end