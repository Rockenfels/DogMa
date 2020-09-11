class CreateDogs < ActiveRecord::Migration[6.0]
  def change
    create_table :dogs do |t|
      t.string :name
      t.string :breed
      t.string :age
      t.string :gender
      t.string :description
      t.string :hometown
      t.belongs_to :owner
      t.belongs_to :shelter
    end
  end
end
