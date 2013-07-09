class CreateContractsUsers < ActiveRecord::Migration
  def change
    create_table :contracts_users do |t|
    	t.belongs_to :contract
    	t.belongs_to :user
    end
  end
end
