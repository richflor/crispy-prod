class UniqueSubscriber < ActiveRecord::Migration[7.0]
  def change
    add_index :subscribers, :email, unique: true
  end
end
