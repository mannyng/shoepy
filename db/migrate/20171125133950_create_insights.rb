class CreateInsights < ActiveRecord::Migration[5.1]
  def up
   #enable_extension 'uuid-ossp'
   create_table :insights do |t|
     t.date :available_date, null: false
     t.string :job_category, null: false
     t.string :employee_category, null: false
     t.string :job_duration, null: false
     t.string :pay_type, null: false
     t.string :employee_type, null: false
     t.string :employee_title, null:false
     t.integer :employer_post_id, null: false
     t.string :employee_experience, null:false
     t.string :status

     t.timestamps
    end
     add_index "insights", ["job_category","employee_category","employee_title","employee_type","pay_type"],name: "JOB_EMPLOYEE_TITLE_TYPE_PAY", using: :btree
     add_index "insights", ["employer_post_id"],name: "EMPLOYER_POST", using: :btree
  end
    def down
      drop_table :insights
    end
end

