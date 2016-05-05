ActiveRecord::Schema.define(version: 1) do
  create_table 'users', force: true

  create_table 'commentables', force: true

  create_table 'comments', force: true do |t|
    t.integer 'commentable_id', null: false
    t.string 'commentable_type', null: false
    t.text 'text', default: ''
    t.integer 'user_id', null: false
    t.string 'ancestry'
    t.text 'parameters', default: ''
    t.timestamps null: false
  end

  add_index 'comments', 'user_id'
  add_index 'comments', 'ancestry'
  add_index 'comments', 'commentable_id'
end
