Vulny
================

Rails 4.2 requires a version of Ruby that uses openssl@1.0. This is pretty difficult to get setup locally so instead a Docker configuration is used:

```
cp config/database.yml.sample config/database.yml
docker-compose build
docker-compose up
```

On first run, run the following commands when the docker container is up and running:

```
docker-compose exec web bin/rake db:migrate RAILS_ENV=development
docker-compose exec web bin/rake db:seed RAILS_ENV=development
```

Then hit http://localhost:3000

Main method used for authenticating users.

```ruby
class SessionsController < ApplicationController
  def create
    username = params[:session][:username]
    password = params[:session][:password]

    # First check to make sure the user exists
    if User.find_by(username: username)
      # If the user exists, check to see if the password is correct, if it is sign the user in.
      if user = User.find_by_sql("SELECT * FROM users WHERE username = '#{ username }' AND password = '#{ password }'").first
        sign_in user
        redirect_to controller: 'users', action: 'index'
      else
        # Show an error that the username and password combination were incorrect
        flash[:error] = "Invalid username/password combination"
        redirect_to root_path
      end
    else
      # Show an error that there is no such username
      flash[:error] = "User #{ username } not found"
      redirect_to root_path
    end
  end
end
```

