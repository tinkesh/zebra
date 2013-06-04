class Crew < ActiveRecord::Base

  has_and_belongs_to_many :jobs
  has_and_belongs_to_many :equipments
  has_many :users

  def label
    label = 'Crew #' + self.id.to_s
    label += ", " + self.name if self.name
    label
  end

  def user_list
    list = []
    self.users.each do |user|
      list << "<span class='#{user.role_symbols}'>#{user.first_name} #{user.last_name}</span>"
    end
    list.join(", ")
  end

  def clear_used_equipment_from_other_crews(equipment_ids)
    @equipments = Equipment.where(:id => equipment_ids).all

      @equipments.each do |x|
        x.update_attributes(:crew_ids => nil)
      end
  end

end
