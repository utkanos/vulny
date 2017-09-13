class StaticPagesController < ApplicationController
  def admin
    if params[:id]
      id = Base64.urlsafe_decode64(params[:id])
      @user = User.exists?(id: id) ? User.find(id) : nil
    else
      redirect_to "/admin?id=#{Base64.urlsafe_encode64('0')}"
    end
  end

  def console
  end

  def configure
  end

  def maint
  end
end
