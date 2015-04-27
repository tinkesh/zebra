class CreateJobEstimates < ActiveRecord::Migration
  def change
    create_table :job_estimates do |t|
      t.string :name_client
      t.string :status
      t.string :reference
      t.text :emails
      t.date :estimate_date
      t.date :expiry_date
      t.text :client_notes
      t.text :terms_and_conditions
      t.decimal :total_amount, default: 0
      t.timestamps
    end

    create_table :estimate_items do |t|
      t.integer :job_estimate_id
      t.string :title
      t.text :description
      t.integer :quantity, default: 1
      t.integer :discount, default: 0
      t.decimal :price, default: 0
      t.decimal :total_price, default: 0
      t.timestamps
    end
  end
end
