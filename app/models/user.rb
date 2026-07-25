class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, on: :create

  before_validation :normalize_email

  private

  def normalize_email
    self.email = email.to_s.downcase.strip
  end
end
