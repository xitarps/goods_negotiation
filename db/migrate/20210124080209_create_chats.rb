class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :product, null: false, foreign_key: true
      t.references :owner, null: false
      t.references :buyer, null: false

      t.timestamps
    end
    #add_fk         to      from    column_name_id
    add_foreign_key :chats, :users, column: :owner_id
    add_foreign_key :chats, :users, column: :buyer_id
  end
end
