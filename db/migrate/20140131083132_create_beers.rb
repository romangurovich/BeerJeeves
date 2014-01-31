class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.float :ibu
      t.float :abv
      t.string :category

      t.timestamps
    end
  end
end
