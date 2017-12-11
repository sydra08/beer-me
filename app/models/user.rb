class User < ApplicationRecord
  has_secure_password

  has_many :user_beers
  has_many :beers, through: :user_beers

  validates :email, uniqueness: true, presence: true, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
  validates :password, length: {minimum: 8}

  # request.env['omniauth.auth']
  # auth['info']['email'] => "sydneycstest@gmail.com"
  # auth['info']['first_name'] => "Sydney"
  # auth['info']['image'] => "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg"
  # auth['info']['last_name'] => "Chun"
  # auth['provider'] => "google_oauth2"
  # auth['uid'] => "114605032996416049559"

  def self.find_or_create_from_auth_hash(auth_hash)
    binding.pry
    where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_initialize.tap do |user|
			user.provider = auth_hash.provider
			user.uid = auth_hash.uid
			user.first_name = auth_hash.info.first_name
			user.last_name = auth_hash.info.last_name
			user.email = auth_hash.info.email
      # create a random password for the user in order to satisfy bcrypt
      user.password = SecureRandom.hex
			user.save!
      # issue is that when you use omniauth, the user doesn't have a password and bcrypt doesn't like that...
    end
  end
end
