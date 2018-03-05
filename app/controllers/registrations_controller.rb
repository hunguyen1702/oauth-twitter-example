class RegistrationsController < Devise::RegistrationsController
  def sign_up_params
    devise_sign_up_params = devise_parameter_sanitizer.sanitize(:sign_up)
    if twitter_data = session["twitter_data"]
      devise_sign_up_params["uid"] = twitter_data["uid"]
    end
    devise_sign_up_params
  end
end
