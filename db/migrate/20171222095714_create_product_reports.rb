class CreateProductReports < ActiveRecord::Migration
  def change
    create_table :product_reports do |t|

      t.timestamps
    end
  end
end
