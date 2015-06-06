class Talephoto < ActiveRecord::Base
	belongs_to :tale
	mount_uploader :cover, CoverUploader
end
