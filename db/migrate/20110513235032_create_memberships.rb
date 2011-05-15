class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.string :title
      t.string :description
      t.boolean :swimming
      t.boolean :tennis
      t.boolean :sauna
      t.integer :guests
      t.decimal :price

      t.timestamps
    end
  end

  def self.down
    drop_table :memberships
  end
end
