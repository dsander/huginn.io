class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_many :scenarios
  validates :nickname, presence: true, length: {minimum: 3}
  validates :nickname, uniqueness: true, allow_blank: true

  def self.from_omniauth(auth)
    User.where(provider: auth.provider, provider_uid: auth.uid).first_or_create do |user|
      user.email        = auth.info.email
      user.password     = Devise.friendly_token[0, 20]
      user.name         = auth.info.name
      user.nickname     = auth.info.nickname
      user.avatar       = auth.info.image
    end
  end

  def update_omniauth_attributes!(auth)
    assign_attributes(provider: auth.provider, provider_uid: auth.uid)
    self.avatar = auth.info.image if avatar.blank?
    self.name   = auth.info.name if name.blank?
    save!
  end
end
