class AddUpvotesToChirps < ActiveRecord::Migration[5.2]
  def change
    add_column :chirps, :upvotes, :integer, default: 0
  end
end
