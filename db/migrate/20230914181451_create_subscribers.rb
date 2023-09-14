class CreateSubscribers < ActiveRecord::Migration[6.1]
  def change
    create_table :subscribers do |t|
      t.string :name
      t.string :email, null: false
      t.string :status, default: 'subscribed'
      t.timestamps
    end
    add_index :subscribers, :email, unique: true
  end
end
