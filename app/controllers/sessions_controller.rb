class SessionsController < ApplicationController
  def create
      redirect_to root_path(:error => "Login temporarily disabled due to site maintenance!" )
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
    UserMailer.welcome_email(email).deliver
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
    redirect_to root_path(error: 'Registration temporarily disabled due to site maintenance!')
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
    redirect_to params[:url]
  end
end
