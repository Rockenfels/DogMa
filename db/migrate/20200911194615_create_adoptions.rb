class CreateAdoptions < ActiveRecord::Migration[6.0]
  def change
    create_table :adoptions do |t|
      t.belongs_to :owner
      t.belongs_to :shelter
      t.belongs_to :dog
      t.string :owner_email
      t.string :shelter_email
      t.boolean :owner_conf, default: false
      t.boolean :shelter_conf, defalut: false
      t.boolean :adopted, default: false
    end
  end
end
