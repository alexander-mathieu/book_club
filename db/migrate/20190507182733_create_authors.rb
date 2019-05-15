class CreateAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :image, default: 'https://styluspub2.presswarehouse.com/publishers/default_cover.png'

      t.timestamps
    end
  end
end
