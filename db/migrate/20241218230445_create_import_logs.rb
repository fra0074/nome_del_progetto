class CreateImportLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :import_logs do |t|
      t.datetime :imported_at
      t.string :source

      t.timestamps
    end
  end
end
