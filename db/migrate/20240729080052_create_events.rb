class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title,         null: false
      t.text :description,     null: false
      t.datetime :date,        null: false
      t.references :chat_room, null: false, foreign_key: true
      t.timestamps
    end
  end
end
