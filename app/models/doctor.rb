class Doctor < ActiveRecord::Base
    has_secure_password
    has_many :doctor_shelters
    has_many :shelters, through: :doctor_shelters
    has_many :doctor_dogs
    has_many :dogs, through: :doctor_dogs
    

    def slug
        self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def self.find_by_slug(name)
        Doctor.find_by(username: name)
    end
end
