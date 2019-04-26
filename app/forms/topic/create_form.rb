class Topic::CreateForm < FormObject
  manage_resource :topic
  manage_attributes :quora_topic_url, :user

  validates_presence_of :quora_topic_url

  before_assign :set_slug
  before_assign :set_name
  # after_save :add_topic_to_user

  # def initialize(topic, user)
  #   super(topic)
  #   @user = user
  # end

  private

  def set_slug
    topic.quora_slug = form_params[:quora_topic_url].match(/topic\/(?=\S*)([\da-zA-Z'-]+)/)[1]
    form_params.delete(:quora_topic_url)
  end

  def set_name
    topic.name = topic.quora_slug.gsub("-", " ").gsub(/\d+/,"").strip
  end

  def add_topic_to_user
  end
end
