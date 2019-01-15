class UsersController < ApplicationController
  def index
     @users = User.all.page(params[:page])
     #全てのユーザーの情報を取得する
  end

  def show
    @user = User.find(params[:id])
    #findでユーザーを指定する
  end

  def new
    @user = User.new
    #とりあえずuserのインスタンスを獲得する必要がある
  end

  def create
    @user=User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
end

private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end