class HomepagesController < ApplicationController
  def index
         if user_signed_in? 
  	 	redirect_to activities_index_path
  	 end
  end
end

