class ActivitiesController < ApplicationController
before_action :authenticate_user!
  def index
   @activities = PublicActivity::Activity.order("created_at desc")#.where(owner_id: current_user.friend_ids, owner_type: "User")
   @current_tales = Tale.includes(:plots).recent
  end
end
