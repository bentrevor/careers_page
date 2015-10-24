class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.references :position, null: false
      t.string :name,         null: false
      t.string :email,        null: false
      t.string :phone,        null: false

      t.timestamps
    end
  end
end
