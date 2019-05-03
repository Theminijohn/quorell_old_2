class CreateJoinTableQuestionsTopics < ActiveRecord::Migration[6.0]
  def change
    create_join_table :questions, :topics do |t|
      t.index [:question_id, :topic_id]
      t.index [:topic_id, :question_id]
    end
  end
end
