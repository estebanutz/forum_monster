class CreateFmTopicsTable < ActiveRecord::Migration
  def self.up
    create_table :fm_topics, :force => true do |t|
      t.string   :title
      t.integer  :hits, :default => 0
      t.boolean  :sticky, :default => false
      t.boolean  :locked, :default => false
      t.integer  :posts_count
      t.integer  :fm_forum_id
      t.integer  :fm_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :fm_topics
  end
end