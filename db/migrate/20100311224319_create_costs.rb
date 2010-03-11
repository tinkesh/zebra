class CreateCosts < ActiveRecord::Migration
  def self.up
    create_table :costs, :force => true do |t|
      t.string :name
      t.string :value
      t.string :description
    end
  end

  def self.down
    drop_table :costs
  end
end
