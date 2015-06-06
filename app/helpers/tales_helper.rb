module TalesHelper
  
  def plots_contributor(tale_id)  
    contributors = Tale.contributors(tale_id)
    contributors.map {|m| link_to m, profiles_index_path(m.id), class: "tale-contributor"}.join(",  ").html_safe
  end


  def shared_emails(tale_id)  
    shared_users = Sharing.where(tale_id: tale_id).pluck(:email) 
  end



end
