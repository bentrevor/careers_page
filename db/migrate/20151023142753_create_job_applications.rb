class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.references :position
      t.string :name
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
