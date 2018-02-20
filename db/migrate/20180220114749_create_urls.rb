class CreateUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :urls do |t|
      t.string :original
      t.string :code
      t.string :hash

      t.timestamps
    end
  end
end
