class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    if current_user
      current_user.update_omniauth_attributes!(request.env["omniauth.auth"])
      redirect_to root_path, flash: {notice: 'Successfully connected to your GitHub account.'}
      return
    end

    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "GitHub") if is_navigational_format?
    else
      redirect_to new_user_registration_path, flash: {error: 'A user with your GitHub email or nickname address already exists.'}
    end
  end

  def failure
    redirect_to root_path
  end
end
