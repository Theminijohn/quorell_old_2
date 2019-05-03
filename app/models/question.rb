class Question < ApplicationRecord
  extend FriendlyId
  friendly_id :quora_slug

  validates_presence_of :quora_slug

  has_and_belongs_to_many :topics

  def quora_url
    "https://www.quora.com/#{self.quora_slug}"
  end
end
