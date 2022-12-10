module FeatureMacros
  def login_admin
    before do
      user = create(:admin_user)
      visit('admin/login')
      fill_in('Email*', with: user.email)
      fill_in('Password*', with: user.password)
      click_button(I18n.t('active_admin.devise.login.title'))
    end
  end
end
