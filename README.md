### Startup

Welcome to my Sinatra CMS Final Project!
    To Start:
        1. Make sure to run 'bundle install' to load all gems. (Check out the Gemfile to view all gems used)
        2. Run rake db:migrate to load in all tables.
        3. Run rake db:seed if you would like to play around with dummy data.
            a. You may login as an Admin with Username: admin, Email: admin@email, Password: admin.
        4. Run shotgun to load up localserver and visit '/doctors/signup' to create a new account.
        5. Visit '/dogs/new' or use the navbar to start creating your first patient!!

### Description 
---This application is all about helping Veterinary specialists keep track of their patients with all of their necessary information, as well as keep track of all appointments for the doctor.

---Each doctor has the ability to create new patients based off of the shelter that the doctor is working with.

---Each doctor can create new appointments with a date and time for any dog that is available to them.

---They can then view a list of all of their appointments either through their home page (/doctors/{username.slug}). A link is provided to direct users to the appointment edit page.

---They can also view an individual dog at (/dogs/{dogname.slug}) that will list all attributes of requested dog. Including: name, breed, age, shelter[website, name, address], and description. Also has a link to direct users to edit the dog's information.
