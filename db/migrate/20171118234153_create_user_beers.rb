class CreateUserBeers < ActiveRecord::Migration[5.1]
  def change
    create_table :user_beers do |t|
      t.integer :user_id
      t.integer :beer_id
      t.boolean :status
      t.text :notes

      t.timestamps
    end
  end
end
