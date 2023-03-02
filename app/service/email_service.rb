class EmailService
  attr_reader :email_form, :current_user

  def initialize(params_email, current_user)
    @current_user = current_user
    @email_form = EmailForm.new(params_email)
  end

  def save
    return unless email_form.valid?

    update_email
  end

  def email_errors
    email_form.errors.full_messages.to_sentence
  end

  def update_email
    current_user.update(email_form.attributes.without(:user_id))
  end
end
