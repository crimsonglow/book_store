class ChangePasswordService
  private_class_method :new

  def self.call(current_user, params)
    new(current_user, params).call
  end

  def call
    { success: change_password }
  end

  private

  attr_reader :current_user, :params

  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def validate_password!
    return true if validate_old_password && validate_new_password && validate_confirm_password

    false
  end

  def validate_old_password
    parse_user_password == params[:old_password]
  end

  def validate_new_password
    parse_user_password != params[:new_password]
  end

  def validate_confirm_password
    params[:new_password] == params[:confirm_password]
  end

  def change_password
    return false unless validate_password!

    current_user.reset_password(params[:new_password], params[:confirm_password])
  end

  def parse_user_password
    @parse_user_password ||= BCrypt::Password.new(current_user.encrypted_password)
  end
end
