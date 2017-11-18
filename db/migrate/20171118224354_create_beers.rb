class CreateBeers < ActiveRecord::Migration[5.1]
  def change
    create_table :beers do |t|
      t.string :name
      t.text :description
      t.integer :brewery_id
      t.integer :category_id
      t.string :abv

      t.timestamps
    end
  end
end
