class TaleGenre < ActiveRecord::Base
  belongs_to :tale
  belongs_to :genre
end
