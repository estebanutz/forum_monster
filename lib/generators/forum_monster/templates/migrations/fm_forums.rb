class CreateFmForumsTable < ActiveRecord::Migration
  def self.up
    create_table :fm_forums, :force => true do |t|
      t.string   :title
      t.text     :description
      t.boolean  :state, :default => true
      t.integer  :topics_count, :default => 0
      t.integer  :posts_count, :default => 0
      t.integer  :position, :default => 0
      t.integer  :fm_category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :fm_forums
  end
end