class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :title
      t.string :video_explanation
      t.text :verbiage
      t.integer :creator_id
      t.integer :signed_by
      t.string :signer_full_name
      t.datetime :signed_date
      t.boolean :agree_to_contract

      t.timestamps
    end
  end
end
