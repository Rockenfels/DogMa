class CreateDogs < ActiveRecord::Migration[6.0]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.string :age
      t.string :gender
      t.string :description
      t.integer :owner_id
      t.string :hometown
      t.integer :shelter_id
    end
  end
end
