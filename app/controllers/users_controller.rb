class UsersController < ApplicationController
  
  before_action :require_user_logged_in, only: [:index, :show]
  #これで親クラスで設定したメソッドを呼び起こすことができる
  def index
     @users = User.all.page(params[:page])
     #全てのユーザーの情報を取得する
  end

  def show
    @user = User.find(params[:id])
    #findでユーザーを指定する
    @microposts = @user.microposts.order('created_at DESC').page(params[:page])
    counts(@user)
    #設定されていた引数に@userを代入する
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
  
  def followings
    @user=User.find(params[:id])
    @followings=@user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end


  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end