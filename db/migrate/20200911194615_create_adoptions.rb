class CreateAdoptions < ActiveRecord::Migration[6.0]
  def change
    create_table :adoptions do |t|
      t.belongs_to :owner_id
      t.belongs_to :shelter_id
      t.belongs_to :dog_id
      t.boolean :owner_conf, default: false
      t.boolean :shelter_conf, defalut: false
      t.boolean :adopted, default: false
    end
  end
end
