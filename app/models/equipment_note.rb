class EquipmentNote < ActiveRecord::Base
   attr_accessible :description, :user_id, :equipment_id

   belongs_to :user
   belongs_to :equipment

   validates_presence_of :description, :user_id, :equipment_id
end
