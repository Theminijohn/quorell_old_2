class Topic < ApplicationRecord
  extend FriendlyId
  friendly_id :quora_slug

  validates_presence_of :quora_slug

  def quora_url
    "https://www.quora.com/topic/#{self.quora_slug}/all_questions"
  end
end
