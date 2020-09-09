class CreateShelters < ActiveRecord::Migration[6.0]
  def change
    create_table :shelters do |t|
      t.string :name
      t.string :password_digest
      t.string :location
      t.string :about_us
    end
  end
end
