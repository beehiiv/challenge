class CreateSubscribers < ActiveRecord::Migration[6.1]
  def change
    create_table :subscribers do |t|
      t.string  :email,      null: false, index: { unique: true }
      t.string  :name,       null: false
      t.boolean :subscribed, default: false, index: true
      t.timestamps
    end
  end
end
