class TweetsController < ApplicationController 
  before_action :set_tweet,only: [ :edit, :show ]
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets=Tweet.includes(:user).order("created_at DESC")
  end

  def new
    @tweet=Tweet.new
  end

  def create
    @tweet= Tweet.new(tweet_params)
    if @tweet.valid?
      @tweet.save
      redirect_to root_path
    else
    render :new
    end
  end

  def destroy
    @tweet=Tweet.find(params[:id])
    @tweet.destroy
  end

  def edit
  end

  def update
    @tweet =Tweet.find(params[:id])
    @tweet.update(tweet_params)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def search
    @tweets = SearchTweetsService.search_tweets(params[:keyword])
    # @tweets = Tweet.search(params[:keyword])
    respond_to do |format|
      format.html
      format.json
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end
end