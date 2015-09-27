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
      # Hacky shit to allow xss
      redirect_to root_path(:error => "Login temporarily disabled due to site maintenance!" )
    end
  end

  def register
  end

  def forgot
  end

  def destroy
    sign_out
    flash[:notice] = "You have been signed out."
    redirect_to root_path
  end
end
