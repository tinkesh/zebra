class AddQuestionsToTimeSheet < ActiveRecord::Migration
  def change
    add_column :time_sheets, :questions, :text
  end
end
