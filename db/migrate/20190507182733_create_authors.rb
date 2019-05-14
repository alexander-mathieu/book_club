class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :image, default: 'assets/default_author.png'

      t.timestamps
    end
  end
end
