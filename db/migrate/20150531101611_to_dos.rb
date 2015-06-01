class ToDos < ActiveRecord::Migration
  def change
    create_table :to_dos do |t|
      t.column :todo, :string
      t.column :complete, :string
    end
  end
end
