class FavosController < ApplicationController
  def create
    micropost=Micropost.find(params[:micropost_id])
    #paramsのidは任意で名ずけて良い
    current_user.favo(micropost)
    flash[:success] = 'この投稿にいいねしました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    micropost=Micropost.find(params[:micropost_id])
    current_user.unfavo(micropost)
    flash[:success] = 'この投稿へのいいねを取り消しました'
    redirect_back(fallback_location: root_path)
  end
end
