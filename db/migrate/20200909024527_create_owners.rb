class CreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :owners do |t|
      t.string :name
      t.string :password_digest
      t.string :location
      t.string :about_me
    end
  end
end
