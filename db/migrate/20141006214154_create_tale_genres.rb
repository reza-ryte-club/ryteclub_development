class CreateTaleGenres < ActiveRecord::Migration
  def change
    create_table :tale_genres do |t|
      t.references :tale, index: true
      t.references :genre, index: true

      t.timestamps
    end
  end
end
