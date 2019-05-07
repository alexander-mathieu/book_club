class CreateBooksByAuthors < ActiveRecord::Migration[5.1]
  def change
    create_table :books_by_authors do |t|
      t.references :book, foreign_key: true
      t.references :author, foreign_key: true

      t.timestamps
    end
  end
end
