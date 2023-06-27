class RemoveNullConstraintFromNameInSubscribers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :subscribers, :name, true
  end
end
