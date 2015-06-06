class Tale < ActiveRecord::Base
	include PublicActivity::Common
  has_one :talephoto, dependent: :destroy
  has_many :tale_genres
  has_many :genres,  through: :tale_genres
  has_many :sharing
  belongs_to :user
	has_many :plots, dependent: :destroy #foreign_key: :trackable_id
  accepts_nested_attributes_for :plots
  #  default_scope { order('updated_at DESC')}
    scope :mystory, ->(user){where('user_id = ?', user) if user.present? }
    scope :not_featured, ->{where(featured: [nil, false])}
	  scope :recent, ->{joins(:plots).where('plots.created_at > ?', 30.days.ago).uniq}
    scope :filter, ->(name){ joins(:genres).where('genres.name = ?', name) if name.present? } 
    scope :featured, ->{where(featured: true).reverse.take(2)}
    scope :contributors, ->(tale_id){
      joins(:plots).where('plots.tale_id =?', tale_id).pluck('plots.user_id').uniq.map{|m| User.where(id: m).first }
    }

    
    
  	acts_as_followable
  	acts_as_likeable

  
end
