class User < ApplicationRecord
  extend FriendlyId
  friendly_id :random_hex

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  enum gender: [:unknown, :male, :female]

  private

  def random_hex
    SecureRandom.hex(3)
  end
end
