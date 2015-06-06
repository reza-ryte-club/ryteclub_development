class Plot < ActiveRecord::Base
  include PublicActivity::Common

  belongs_to :tale
  belongs_to :user
  has_many :plotphotos, dependent: :destroy
  default_scope { order("tale_id DESC")}

  #scope :recent, ->{ where('created_at > ?', 5.days.ago)}
  
  acts_as_likeable
  
end
