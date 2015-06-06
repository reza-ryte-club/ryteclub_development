module BiosHelper
  

  def get_bio_id(user_id)
  	bio_id = Bio.where(user_id: user_id) 
  	
  end



end
