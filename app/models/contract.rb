class Contract < ActiveRecord::Base
	attr_accessible :title, :video_explanation, :verbiage, :creator_id, :contract_document, :signed_by, :signer_full_name, :signed_date, :agree_to_contract, :user_ids
	has_attached_file :contract_document
	has_and_belongs_to_many :users
	self.per_page = 10

	validates :title, :length => {:minimum => 2}, :presence => true
	validates :verbiage, :length => {:minimum => 10}, :unless => :contract_document?
	validates :contract_document, :presence => true, :unless => :verbiage?
	validates :signer_full_name, :presence => true, :length => {:minimum => 2}, :on => :update, :if => :agree_to_contract
	ActiveSupport.on_load(:active_record) do
		validates :agree_to_contract, :acceptance => { :accept => true }, :on => :update, :if => :signer_full_name
	end

	scope :unsigned, -> { where("signed_date IS NULL")}

	def youtube_embed
	  if self.video_explanation[/youtu\.be\/([^\?]*)/]
	    youtube_id = $1
	  else
	    # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
	    self.video_explanation[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
	    youtube_id = $5
	  end

	  %Q{<iframe title="YouTube video player" width="640" height="390" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
	end
end
