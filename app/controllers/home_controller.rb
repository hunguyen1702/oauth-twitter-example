class HomeController < ApplicationController
  def index
    if current_user
      redirect_to home_tweet_path
    end
  end

  def tweet
    if request.method == "POST"
      tweet_response = get_access_token.
        request(:post, "https://api.twitter.com/1.1/statuses/update.json",
          {status: request.params[:tweet]})
      case tweet_response
      when Net::HTTPOK
        flash.now[:success] = "Tweet successful"
      else
        flash.now[:alert] = "Failed"
      end
    end
  end

  private

  def get_access_token
    twitter_data = session["twitter_data"]
    consumer = OAuth::Consumer.new(twitter_data["app_id"],
      twitter_data["secret"], {:site => "http://api.twitter.com"})
    token_hash = {oauth_token: twitter_data["access_token"],
      oauth_token_secret:twitter_data["access_secret"]}
    OAuth::AccessToken.from_hash(consumer, token_hash)
  end
end
