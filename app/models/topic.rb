class Topic < ApplicationRecord
  extend FriendlyId
  friendly_id :quora_slug

  validates_presence_of :quora_slug

  has_and_belongs_to_many :questions

  def quora_url
    "https://www.quora.com/topic/#{self.quora_slug}/all_questions"
  end
end
