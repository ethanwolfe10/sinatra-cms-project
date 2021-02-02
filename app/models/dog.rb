class Dog < ActiveRecord::Base
    has_many :doctor_dogs
    has_many :doctors, through: :doctor_dogs
    belongs_to :breed
    belongs_to :shelter 

    def slug
        self.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') + '-' + self.breed.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '') + '-' + "#{self.age}"
    end

    def self.find_by_slug(name)
        found_slug = Dog.all.select {|dog| dog.slug == name}
        found_slug[0]
    end
end
