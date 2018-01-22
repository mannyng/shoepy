class CreateJobLocations < ActiveRecord::Migration[5.1]
  def up
    enable_extension 'uuid-ossp'
    create_table :job_locations, uuid: :id do |t|
      t.string :location, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.integer :employer_post_id, null: false
      t.string :status
      t.float   :latitude
      t.float   :longitude

      t.timestamps
    end
      add_index "job_locations", ["city","state","employer_post_id","latitude","longitude"],name: "CITY_STATE_EMPLOYER", using: :btree
  end
  def down
   drop_table :job_locations
  end
end

