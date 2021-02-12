class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :send_friend_id, index: true
      t.integer :recieved_friend_id, index: true
      t.integer :status

      t.timestamps
    end

    add_foreign_key :friendships, :users,column: :send_friend_id
    add_foreign_key :friendships, :users,column: :recieved_friend_id

  end
end
