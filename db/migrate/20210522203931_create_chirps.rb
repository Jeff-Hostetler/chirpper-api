class CreateChirps < ActiveRecord::Migration[5.2]
  def change
    create_table :chirps do |t|
      t.string :text, limit: 140, null: false

      t.timestamps
    end
  end
end
