class CreateEmployeePosts < ActiveRecord::Migration[5.1]
 def up
   #enable_extension 'uuid-ossp';
   # create_table :employee_posts, id: :uuid do |t|
    create_table :employee_posts do |t|  
     t.string :job_category, null: false
     t.string :employee_category, null: false
     t.string :job_duration, null: false
     t.string :pay_type, null: false
     t.string :employee_type, null: false
     t.string :employee_title, null:false
     t.string :employee_experience, null:false
     t.integer :customer_id, null:false
     t.text :description, null:false
     t.string :status

      t.timestamps
    end
    add_index "employee_posts",["employee_title"],name: "EMPYEE_TTLE", using: :btree
    add_index "employee_posts", ["employee_type"],name: "EMPLOYEE_TYPE",using: :btree
    add_index "employee_posts", ["employee_category"],name:"EMPLOYEE_CATEGORY",using: :btree
    add_index "employee_posts", ["job_duration","pay_type"],name: "EMPLOYEE_PAY", using: :btree
    add_index "employee_posts", ["employee_experience"],name: "EXPERIENCE_EMPLOYEE", using: :btree
 end
  def down
    drop_table :employee_posts
  end

end
