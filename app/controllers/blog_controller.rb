class BlogController < ApplicationController
  before_action :redirect_to_index, except: :index

  def index
    @articles = Article.includes(:user).page(params[:page]).per(5).order("created_at DESC")
  end

  def show
    @articles = Article.find(params[:id])
  end

  def new
    @blog=Article.new
  end

  def create
    Article.create(title: articles_params[:title], image: articles_params[:image], content: articles_params[:content], user_id: current_user.id)
  end

  def destroy
    articles = Article.find(id_params[:id])
    articles.destroy if articles.user_id == current_user.id
  end

  def edit
    @articles = Article.find(id_params[:id])
  end

  def update
    articles = Article.find(id_params[:id])
    articles.update(articles_params) if articles.user_id == current_user.id
  end

  private
  def articles_params
    params.require(:article).permit(:title, :image, :content)
  end

  def id_params
    params.permit(:id)
  end

  def redirect_to_index
    redirect_to :action => "index" unless user_signed_in?
  end
end

