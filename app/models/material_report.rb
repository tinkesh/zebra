class MaterialReport < ActiveRecord::Base

  belongs_to :job
  has_and_belongs_to_many :load_sheets
  has_and_belongs_to_many :gun_sheets

  validates_presence_of :yellow_rate, :on => :save, :message => "can't be blank"
  validates_presence_of :white_rate, :on => :save, :message => "can't be blank"

  def label
    "Material Report ##{self.id}"
  end

  def yellow_rate
    0
  end

  def white_rate
    0
  end

end