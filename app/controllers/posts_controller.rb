class PostsController < ApplicationController
  before_action :trepass_not_user
  def index
    @posts=Post.where(user_id: @current_user.id).order(created_at: :desc)
  end

  def show
    @post=Post.find_by(id: params[:id])
  end

  def new
    @post=Post.new
  end

  def create
    @post=Post.new(title: params[:title], content: params[:content], user_id: @current_user.id)
    if @post.save && params[:image]
      @post.image="#{@post.id}.jpg"
      image=params[:image]
      File.binwrite("public/post_images/#{@post.image}", image.read)
      @post.save
      flash[:notice]="日記を保存しました。お疲れさまです。"
      redirect_to("/posts/index")
    elsif @post.save
      flash[:notice]="日記を保存しました。お疲れさまです。"
      redirect_to("/posts/index")
    else
      flash[:notice]="内容がありません"
      render("posts/new")
    end
  end

  def edit
    @post=Post.find_by(id: params[:id])
  end

  def update
    @post=Post.find_by(id: params[:id])
    @post.title=params[:title]
    @post.content=params[:content]
    if params[:image]
      @post.image="#{@post.id}.jpg"
      image=params[:image]
      File.binwrite("public/post_images/#{@post.image}", image.read)
    end
    if @post.save
      flash[:notice]="日記を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def destroy
    @post=Post.find_by(id: params[:id])
    @bookmark=Bookmark.find_by(post_id: @post.id)
    if @bookmark
      @bookmark.destroy
    end
    @post.destroy
    flash[:notice]="日記を削除しました"
    redirect_to("/posts/index")
  end
end
