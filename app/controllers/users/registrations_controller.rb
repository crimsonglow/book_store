class Users::RegistrationsController < Devise::RegistrationsController # rubocop:disable Style/ClassAndModuleChildren
  before_action only: :create

  EMAIL_EXISTS = 'Email exists'.freeze

  def create
    return checkout_registrate_user if email_taken_in_quick_signup?
    return redirect_to(new_user_password_path, notice: EMAIL_EXISTS) if email_exists_in_quick_signup?

    super do |resource|
      resource.skip_confirmation!
      resource.save
    end
  end

  def checkout_registrate_user
    secret_password_token
    build_resource(sign_up_params)
    resource.skip_confirmation!
    resource.save ? authenticate_user : redirect_to(user_session_path)
  end

  def authenticate_user
    sign_up(resource_name, resource)
    resource.send_reset_password_instructions
    redirect_to checkout_path(step: :address)
  end

  private

  def secret_password_token
    params[:user][:password] = params[:user][:password_confirmation] = Devise.friendly_token[0, 10]
  end

  def email_taken_in_quick_signup?
    params[:checkout_signup] && !current_user
  end

  def email_exists_in_quick_signup?
    params[:checkout_signup] && current_user
  end

  def current_user
    @current_user ||= User.where(email: params.dig(:user, :email)).present?
  end
end
