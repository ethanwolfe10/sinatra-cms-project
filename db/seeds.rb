shelter_list = {
    "Shelter1" => {
        :address => "address1",
        :website => "website1"
    },
    "Shelter2" => {
        :address => "address2",
        :website => "website2"
    },
    "Shelter3" => {
        :address => "address3",
        :website => "website3"
    },
    "Shelter4" => {
        :address => "address4",
        :website => "website4"
    },
    "Shelter5" => {
        :address => "address5",
        :website => "website5"
    }
}

shelter_list.each do |name, shelter_hash|
    p = Shelter.new
    p.name = name
    shelter_hash.each do |attribute, value|
        p[attribute] = value
    end
    p.save
end

breed_list = ["Pitbull", "Schnoodle", "Cocker Spaniel", "Springer Spaniel", "Husky"]

breed_list.each do |name|
    p = Breed.new
    p.name = name
    p.save
end

dog_list = {
    "Bella" => {
        :age => 12,
        :breed_id => '1',
        :shelter_id => '1'
    },
    "Pepper" => {
        :age => 12,
        :breed_id => '2',
        :shelter_id => '1'
    },
    "Joe" => {
        :age => 12,
        :breed_id => '3',
        :shelter_id => '1'
    },
    "Lillie" => {
        :age => 12,
        :breed_id => '4',
        :shelter_id => '1'
    },
    "Naia" => {
        :age => 12,
        :breed_id => '5',
        :shelter_id => '1'
    },
    "Bella2" => {
        :age => 12,
        :breed_id => '1',
        :shelter_id => '2'
    },
    "Pepper2" => {
        :age => 12,
        :breed_id => '2',
        :shelter_id => '2'
    },
    "Joe2" => {
        :age => 12,
        :breed_id => '3',
        :shelter_id => '2'
    },
    "Lillie2" => {
        :age => 12,
        :breed_id => '4',
        :shelter_id => '2'
    },
    "Naia2" => {
        :age => 12,
        :breed_id => '5',
        :shelter_id => '2'
    },
    "Bella3" => {
        :age => 12,
        :breed_id => '1',
        :shelter_id => '3'
    },
    "Pepper3" => {
        :age => 12,
        :breed_id => '2',
        :shelter_id => '3'
    },
    "Joe3" => {
        :age => 12,
        :breed_id => '3',
        :shelter_id => '3'
    },
    "Lillie3" => {
        :age => 12,
        :breed_id => '4',
        :shelter_id => '3'
    },
    "Naia3" => {
        :age => 12,
        :breed_id => '5',
        :shelter_id => '3'
    },
    "Bella4" => {
        :age => 12,
        :breed_id => '1',
        :shelter_id => '4'
    },
    "Pepper4" => {
        :age => 12,
        :breed_id => '2',
        :shelter_id => '4'
    },
    "Joe4" => {
        :age => 12,
        :breed_id => '3',
        :shelter_id => '4'
    },
    "Lillie4" => {
        :age => 12,
        :breed_id => '4',
        :shelter_id => '4'
    },
    "Naia4" => {
        :age => 12,
        :breed_id => '5',
        :shelter_id => '4'
    },
    "Bella5" => {
        :age => 12,
        :breed_id => '1',
        :shelter_id => '5'
    },
    "Pepper5" => {
        :age => 12,
        :breed_id => '2',
        :shelter_id => '5'
    },
    "Joe5" => {
        :age => 12,
        :breed_id => '3',
        :shelter_id => '5'
    },
    "Lillie5" => {
        :age => 12,
        :breed_id => '4',
        :shelter_id => '5'
    },
    "Naia5" => {
        :age => 12,
        :breed_id => '5',
        :shelter_id => '5'
    },
}

dog_list.each do |name, dog_hash|
    p = Dog.new
    p.name = name
    dog_hash.each do |attribute, value|
        p[attribute] = value
    end
    p.save
end

admin = Doctor.create(username: 'admin', password: 'admin', email: 'admin@email')
admin.save
Shelter.all.each do |shelter|
    shelter.doctors << admin
    admin.shelters << shelter 
end
