class CreateDogs < ActiveRecord::Migration[6.0]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.string :age
      t.string :gender
      t.string :description
      t.string :shelter_id
      t.string :hometown
      t.string :owner_id
    end
  end
end
