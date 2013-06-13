class Comment < ActiveRecord::Base
  belongs_to :job
  belongs_to :user

  validates_presence_of :text, :job_id

  scope :sorted, -> { order('comments.created_at ASC') }

  def self.import_job_notes_in_comments
    # Run me once and then delete me
    Job.all.each do |job|
      next if job.notes.blank?
      job.comments.create(:text => job.notes)
      job.notes = nil
      job.save
    end
  end

end
