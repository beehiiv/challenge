class CreateSubscribers < ActiveRecord::Migration[6.1]
  def change
    create_table :subscribers do |t|
      t.string :name
      t.string :email, null: false
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
