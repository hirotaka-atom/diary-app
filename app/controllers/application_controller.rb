class ApplicationController < ActionController::Base
before_action :set_current_user

  def set_current_user
    @current_user=User.find_by(id: session[:user_id])
  end

  def trepass_user
    if session[:user_id]
      flash[:notice]="権限がありません"
      redirect_to("/posts/index")
    end
  end

  def trepass_not_user
    if session[:user_id]==nil
      flash[:notice]="ログインが必要です"
      redirect_to("/users/login")
    end
  end
end
