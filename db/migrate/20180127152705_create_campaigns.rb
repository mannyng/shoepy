class CreateCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns do |t|
      t.json :pictures
      t.string :title
    end
  end
end
