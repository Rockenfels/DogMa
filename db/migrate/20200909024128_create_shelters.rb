class CreateShelters < ActiveRecord::Migration[6.0]
  def change
    create_table :shelters do |t|
      t.string :name
      t.string :email
      t.string :home_state
      t.string :about_us
      t.string :password_digest
    end
  end
end
