class AddAttachmentsToJobApplications < ActiveRecord::Migration
  def change
    add_attachment :job_applications, :resume
    add_attachment :job_applications, :cover_letter
  end
end
