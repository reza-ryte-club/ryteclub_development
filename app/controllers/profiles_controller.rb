class ProfilesController < ApplicationController
before_action :authenticate_user!, only: [ :follow, :unfollow]

  def index
    @userFirstName = User.where(id: params[:format]).pluck(:firstname)
    @followers = Follow.where(followable_type: User, followable_id: params[:format]).pluck(:follower_id)
    @followings = Follow.where(follower_type: User, follower_id: params[:format],followable_type: User).pluck(:followable_id)
    @numberOfFollowers = Follow.where(followable_type: User, followable_id: params[:format]).count
    @numberOfFollowings = Follow.where(follower_type: User, follower_id: params[:format],followable_type: User).count
    @idOfStoriesFollowedByMe = Follow.where(follower_type: User, follower_id: params[:format],followable_type: Tale).pluck(:followable_id)
    @numberOfFollowingsTale = Follow.where(follower_type: User, follower_id: params[:format],followable_type: Tale).count
    @bio = Bio.where(user_id: params[:format])
    
    @story_by_me = Tale.where(user_id: params[:format]).order(:updated_at).reverse
    @published_story_by_me = Tale.where(user_id: params[:format], private_flag: 0).order(:updated_at).reverse
    @number_of_stories_created_by_me = Tale.where(user_id: params[:format]).count
    
    @storiesFollowedByMe = Tale.where(id: @idOfStoriesFollowedByMe)



  end

  def follow

     #follow author 
  	 current_user.follow!(User.find(params[:followings_id]))
     


     redirect_to profiles_index_path(User.find(params[:followings_id])) 


     #create notification
     n = Journal.new
     n.notification_type = "Follow"
     identities = Follow.where(follower_id: current_user.id, followable_type: User, followable_id: params[:followings_id]).pluck(:id)
     n.notification_id = identities[0]
     n.notification_to = params[:followings_id]
     n.save

     social_identity = Identity.where(user_id: params[:followings_id], provider: "facebook")
     
     
     if(social_identity[0]!=nil)

              notification_string = current_user.firstname + " starts following you"
              @g = Koala::Facebook::API.new(Koala::Facebook::OAuth.new("878916972138133","1c19d3ff9cf496854d4e506030f592b1").get_app_access_token)
              @g.put_connections(social_identity[0].uid, "notifications", template: notification_string, href: "http://ryte.club")



     end         



     				
  end

  def unfollow
  	 
     #remove notification 
     identities = Follow.where(follower_id: current_user.id, followable_type: User, followable_id: params[:followings_id]).pluck(:id)
     journal = Journal.where(notification_type: "Follow", notification_id: identities[0], notification_to: params[:followings_id])
     Journal.delete(journal)

     #unfollow author
     current_user.unfollow!(User.find(params[:followings_id]))


     redirect_to profiles_index_path(User.find(params[:followings_id]))				 				
 		  	
  end
end
