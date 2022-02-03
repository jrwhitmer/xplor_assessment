class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :status
      t.string :current_user, null: false, default: "Library"
      t.references :library, null: false, foreign_key: true

      t.timestamps
    end
  end
end
