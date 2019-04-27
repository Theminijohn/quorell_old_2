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
    topic_name = topic_params[:quora_slug].gsub("-", " ").gsub(/\d+/,"").strip

    if @topic = Topic.where(topic_params).first_or_create {|t| t.name = topic_name }
      redirect_to topics_path, notice: 'Topic was added to your account'
    end
  rescue StandardError => e
    redirect_to new_topic_path, notice: "We encountered a problem while adding this topic. Is the URL correct?"
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
    redirect_to topics_url, notice: 'Topic was successfully removed'
  end

  private

  def set_topic
    @topic = Topic.friendly.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(:quora_slug)
  end
end
