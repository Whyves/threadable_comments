# Migration responsible for creating a table for comments
class CreateComments < ActiveRecord::Migration
  # Create table
  def self.up
    create_table :comments, force: true do |t|
      t.belongs_to :commentable, :polymorphic => true, null: false
      t.integer 'user_id', null: false
      t.text 'text', default: ''
      t.text 'parameters', default: ''
      t.string 'ancestry'
      t.timestamps null: false
    end

    add_index :comments, :user_id
    add_index :comments, :ancestry
    add_index :comments, :commentable_id
  end

  # Drop table
  def self.down
    drop_table :comments
  end
end