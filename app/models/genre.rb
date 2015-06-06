class Genre < ActiveRecord::Base
  has_many :tale_genres
  has_many :tales, through: :tale_genres
end
