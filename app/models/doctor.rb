class Doctor < ActiveRecord::Base
    has_secure_password
    has_many :appointments
    has_many :dogs, through: :appointments

    def slug
        self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end

    def self.find_by_slug(name)
        found_slug = User.all.select {|user| user.slug == name}
        found_slug[0]
    end
end
