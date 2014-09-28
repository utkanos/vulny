Vulny
================

[![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)


To run
```
bundle install
rake db:migrate db:seed
rails server
```

Then hit http://localhost:3000


For the job fair, we should only need to show the following method in
the Sessions controller as it shows the SQL injection as well as the XSS

```ruby
class SessionsController < ApplicationController
  def create
    username = params[:session][:username]
    password = params[:session][:password]

    # First check to make sure the user exists
    if User.find_by(username: username)
      # If the user exists, check to see if the password is correct, if it is sign the user in.
      if user = User.where("username = '#{ username }' AND password = '#{ password }'").first
        sign_in user
        redirect_to controller: 'users', action: 'index'
      else
        # Show an error that the username and password combination were incorrect
        # Need to mark this string as html_safe, otherwise I can't insert the link into the flash.
        flash.now[:error] = "Invalid username/password combination, <a href='/signin'>click here</a> to try again".html_safe
        render "error"
      end
    else
      # Show an error that there is no such username
      # Need to mark this string as html_safe, otherwise I can't insert the link into the flash.
      flash.now[:error] = "User #{ username } not found, <a href='/signin'>click here</a> to try again".html_safe
      render "error"
    end
  end
end
```

