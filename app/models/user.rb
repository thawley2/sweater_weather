class User < ApplicationRecord
  before_create :set_api_key
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password

  private
    def set_api_key
      self.api_key = SecureRandom.hex(13)
    end
end