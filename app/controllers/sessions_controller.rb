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
  
  def register_send
    session = params[:session]
    if session
      email = session[:email]
    else
      redirect_to root_path(error: 'No email entered!')
    end
    UserMailer.welcome_email(email)
    redirect_to root_path(error: 'Please check your email for a confirmation link.')
  end
  
  def confirm
    @email = params[:email]
    if user = User.find_by_username(@email)
      sign_in user
      flash[:error] = 'You already have an account!'
      redirect_to controller: 'users', action: 'index'
    end
  end
  
  def confirm_save
    redirect_to root_path(error: 'Thank you, your password has been saved.')
  end

  def forgot
  end
  
  def forgot_lookup
    session = params[:session]
    if session
      email = session[:email]
    else
      redirect_to root_path(error: 'No email entered!')
    end
    if (user = User.find_by_username(email)) && (!user.nil?) && user.secret_question?
      @secret_question = user.secret_question
      @email = email
    else
      redirect_to root_path(error: 'No secret question exists for that user.')
    end
  end
  
  def forgot_submit
    session = params[:session]
    if session
      email = session[:email]
      secret_answer = session[:secret_answer]
    else
      redirect_to root_path(error: 'No email entered!')
    end
    if user = User.find_by_sql("SELECT * FROM users WHERE username = '#{email}' AND secret_answer = '#{secret_answer}'").first
      sign_in user
      redirect_to controller: 'users', action: 'index'
    else
      redirect_to root_path(error: 'Incorrect secret question answer.')
    end
  end

  def destroy
    sign_out
    flash[:notice] = "You have been signed out."
    redirect_to root_path
  end
end
