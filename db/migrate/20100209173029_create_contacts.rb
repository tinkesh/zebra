class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :name
      t.string :company
      t.string :address
      t.string :city
      t.string :province
      t.string :phone
      t.string :email
      t.string :subject
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
