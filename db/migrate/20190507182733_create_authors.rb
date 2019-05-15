class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :image, default: 'https://torrentfreak.com/wp-content/themes/torrentfreakredux/assets/img/default-author.jpg'

      t.timestamps
    end
  end
end
