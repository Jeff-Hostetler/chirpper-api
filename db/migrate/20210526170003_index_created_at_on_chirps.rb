class IndexCreatedAtOnChirps < ActiveRecord::Migration[5.2]
  def change
    add_index :chirps, :created_at
  end
end
