class FmCreateFmPostsTable < ActiveRecord::Migration
  def self.up
    create_table :fm_posts, :force => true do |t|
      t.text     :body
      t.integer  :fm_forum_id
      t.integer  :fm_topic_id
      t.integer  :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :fm_posts
  end
end