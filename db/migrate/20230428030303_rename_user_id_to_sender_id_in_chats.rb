class RenameUserIdToSenderIdInChats < ActiveRecord::Migration[7.0]
  def change
    rename_column :chats, :user_id, :sender_id
  end
end
