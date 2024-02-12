class CreateSubscribers < ActiveRecord::Migration[6.1]
  def change
    create_table :subscribers do |t|
      t.string :name
      t.string :email
      t.string :status

      t.timestamps
    end
  end
end
