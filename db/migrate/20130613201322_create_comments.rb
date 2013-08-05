class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments, :force => true do |t|
      t.text :text
      t.integer :user_id
      t.integer :job_id

      t.timestamps
    end
  end
end
