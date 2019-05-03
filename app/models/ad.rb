class Ad < ApplicationRecord
  extend FriendlyId
  friendly_id :random_hex

  private

  def random_hex
    SecureRandom.hex(6)
  end
end
