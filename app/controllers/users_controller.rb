class UsersController < ApplicationController
  before_action :trepass_user,{only: [:new, :create, :login_form, :login]}
  before_action :trepass_not_user,{only: [:show, :edit, :update, :logout]}

  def home
  end

  def new
    @user=User.new
  end

  def show
    @user=User.find_by(id: params[:id])
    #@user=User.find(params[:id])
  end

  def create
    #@user=User.new(name: "ユーザー", email: params[:email], password: params[:password], image_name: "th_app_icon_account.jpg")
    @user=User.new(user_params)
    if @user.save
      session[:user_id]=@user.id
      flash[:sucess]="新規登録が完了しました。diary appへようこそ!"
      #redirect_to("/posts/index")
      redirect_to @user #(user_url(@user))
    else
      render("users/new")
    end
  end

  def edit
    @user=User.find_by(id: params[:id])
  end

  def update
    @user=User.find_by(id: params[:id])
    @user.name=params[:name]
    @user.email=params[:email]
    @user.password=params[:password]
    if params[:image]
      @user.image_name="#{@user.id}.jpg"
      image=params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    if @user.save
      flash[:notice]="ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      flash[:notice]="いずれかが入力されてません"
      render("users/edit")
    end
  end

  def login_form
  end

  def login
    @user=User.find_by(email: params[:email], password: params[:password])
    if @user
      session[:user_id]=@user.id
      flash[:notice]="ログインしました"
      redirect_to("/posts/index")
    else
      @email=params[:email]
      @password=params[:password]
      flash[:notice]="メールアドレスまたはパスワードが間違っています"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id]=nil
    flash[:notice]="ログアウトしました"
    redirect_to("/users/login")
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
