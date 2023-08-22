class CreateSubscribers < ActiveRecord::Migration[6.1]
  def change
    create_table :subscribers do |t|
      t.string :name, null: false
      t.string :email, null: false, unique: true
      t.string :status, null: false, default: "inactive"
      t.timestamps
    end
  end
end
