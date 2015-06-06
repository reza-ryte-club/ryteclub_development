class ImageUploader < CarrierWave::Uploader::Base

   include CarrierWave::MiniMagick

   storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  #this method is responsible for keeping a resized version of uploaded images.
  #the version method is a class method, so I've used self.class in order
  #to call it
  #run the store_dimensions methods
      process :store_dimensions

  def store_dimensions
         if file && model
          width, height = ::MiniMagick::Image.open(file.file)[:dimensions]
            if width>700
                  finalHeight=((700*height)/width)
                  self.class.version :best do
                    process :resize_to_fill => [700,finalHeight]
                  end
            else
                  self.class.version :best do
                    process :resize_to_fill => [width,height]
                  end
            end
          end
    end


#this would load compressed version during loading
#if it is ommited, after restarting server, images won't be loaded
version :best do
end
    
end
