class Contract < ActiveRecord::Base
	attr_accessible :title, :video_explanation, :verbiage, :creator_id, :contract_document, :signed_by, :signer_full_name, :signed_date, :agree_to_contract, :user_ids
	has_and_belongs_to_many :users

	ActiveSupport.on_load(:active_record) do
		validates :agree_to_contract, :acceptance => { :accept => true }, :on => :update, :if => :signer_full_name
	end
end
