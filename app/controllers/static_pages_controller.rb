class StaticPagesController < ApplicationController
  def admin
    if params[:id]
      id = Base64.urlsafe_decode64(params[:id])
      @user = User.exists?(id: id) ? User.find(id) : nil
    else
      id = Base64.urlsafe_encode64('0')
      redirect_to "/admin?id=#{id}"
    end
  end

  def console
  end

  def configure
  end

  def maint
  end
end
