class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def show
  end

  def new
    @topic = Topic.new
  end

  def edit
  end

  def create
    topic_slug = topic_params[:quora_topic_url].match(/topic\/(?=\S*)([\da-zA-Z'-]+)/)[1]
    topic_name = topic_slug.gsub("-", " ").gsub(/\d+/,"").strip

    if @topic = Topic.where(quora_slug: topic_slug).first_or_create {|t| t.name = topic_name }
      redirect_to topics_path, notice: 'Topic was added to your account'
    else
      render :new
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to @topic, notice: 'Topic was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_url, notice: 'Topic was successfully destroyed.'
  end

  private

  def set_topic
    @topic = Topic.friendly.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:quora_topic_url)
  end
end
