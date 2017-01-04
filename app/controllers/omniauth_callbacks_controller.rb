class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    service = CreateOmniauthUserService.new(request.env["omniauth.auth"])

    if service.call
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", kind: "Google"
      sign_in_and_redirect service.oauth_user, event: :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url
    end
  end
end
