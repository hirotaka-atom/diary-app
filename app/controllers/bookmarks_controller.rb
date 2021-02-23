class BookmarksController < ApplicationController
  def index
    @bookmarks=Bookmark.where(user_id: @current_user.id)
  end

  def create
    @bookmark=Bookmark.new(post_id: params[:post_id], user_id: @current_user.id)
    @post=Post.find_by(id: params[:post_id])
    @bookmark.save
    flash[:notice]="ブックマークしました"
    redirect_to("/posts/#{@post.id}")
  end

  def destroy
    @bookmark=Bookmark.find_by(post_id: params[:post_id])
    @post=Post.find_by(id: params[:post_id])
    @bookmark.destroy
    flash[:notice]="ブックマークを解除しました"
    redirect_to("/posts/#{@post.id}")
  end
end
