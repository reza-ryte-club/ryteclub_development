class Plotphoto < ActiveRecord::Base
	belongs_to :plot
	mount_uploader :image, ImageUploader
end
