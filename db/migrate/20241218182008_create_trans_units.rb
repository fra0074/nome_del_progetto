class CreateTransUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :trans_units do |t|
      t.string :resname
      t.text :source
      t.integer :trans_unit_id

      t.timestamps
    end
  end
end
