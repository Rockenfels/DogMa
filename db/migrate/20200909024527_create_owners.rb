class CreateOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :owners do |t|
      t.string :name
      t.string :email
      t.string :hometown
      t.string :about_me
      t.string :password_digest
    end
  end
end
