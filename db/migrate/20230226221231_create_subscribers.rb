class CreateSubscribers < ActiveRecord::Migration[6.1]
  def change
    create_table :subscribers do |t|
      t.string :name
      t.string :email, null: false, index: {unique: true}
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
