class CreateSubscribers < ActiveRecord::Migration[6.1]
  def change
    create_table :subscribers do |t|
      t.text :name
      t.text :email
      t.text :status, :default => "inactive"

      t.timestamps
    end
  end
end
