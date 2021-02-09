class Dog < ActiveRecord::Base
    has_many :doctor_dogs
    has_many :doctors, through: :doctor_dogs
    belongs_to :breed
    belongs_to :shelter 

    def slug
        self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') + '-' + self.id.to_s
    end

    def self.find_by_slug(name)
        name = name.split("-")
        Dog.find_by(id: name[-1])
    end
end
