class LoadSheet < ActiveRecord::Base

  versioned

  belongs_to :job
  belongs_to :equipment
  has_many :load_entries, :dependent => :destroy
  accepts_nested_attributes_for :load_entries, :reject_if => lambda { |a| a[:material_id].blank? }, :allow_destroy => true

  after_create :deliver_new_load_sheet

  def deliver_new_load_sheet
     Notifier.deliver_new_load_sheet(self)
   end

   def label
     "Load Sheet ##{self.id} #{self.date.to_date.strftime('%b-%d-%y')}"
   end

end