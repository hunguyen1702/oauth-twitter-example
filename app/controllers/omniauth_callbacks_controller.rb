class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    twitter_data = request.env["omniauth.auth"]
    @user = User.find_or_create_by uid: twitter_data.uid
    session["twitter_data"] = {
      uid: twitter_data.uid,
      app_id: twitter_data.extra.access_token.consumer.key,
      secret: twitter_data.extra.access_token.consumer.secret,
      access_token: twitter_data.extra.access_token.token,
      access_secret: twitter_data.extra.access_token.secret
    }

    if @user.persisted?
      sign_in :user, @user
      redirect_to root_path
    else
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
