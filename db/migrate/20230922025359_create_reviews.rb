class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.text :content
      t.integer :movie_id
      t.integer :score
      t.boolean :recommended, default: false
      t.timestamps
    end
  end
end
