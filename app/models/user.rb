class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :orders, dependent: nil
  has_many :addresses, as: :resource, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  validate :password_complexity

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end
  end

  def password_complexity
    return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])/

    errors.add :password, 'Complexity requirement not met. Please use: 1 uppercase, 1 lowercase, 1 digit'
  end
end
