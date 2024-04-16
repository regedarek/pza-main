class CreateMessagingComments < ActiveRecord::Migration[7.1]
  def change
    create_table :messaging_comments, id: :uuid do |t|
      t.references :commentable, polymorphic: true, null: false, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
