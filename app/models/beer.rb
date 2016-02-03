class Beer < ActiveRecord::Base
	include RatingAverage
	
  	belongs_to :brewery
  	has_many :ratings
  	has_many :ratings, dependent: :destroy

  	def average_rating
    	ratings.average(:score)
  	end

  	def to_s
    	"#{self.name} #{self.brewery}"
  	end
end