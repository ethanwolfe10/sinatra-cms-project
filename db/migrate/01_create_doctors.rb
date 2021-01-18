class CreateDoctors < ActiveRecord::Migration
    def change
        create_table :doctors do |t|
            t.string :username
            t.string :email
            t.string :password_digest
        end
    end
end