module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    #session(サーバー側)にuser.idが入っているかどうかを確認
    #サーバーにあるsessionを参照している動作である
  end
  def logged_in?
    !!current_user
    #ログインしてればtrueを返す、それ以外はfalseを返す
  end
end
