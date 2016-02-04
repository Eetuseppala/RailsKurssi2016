class User < ActiveRecord::Base
	
	include RatingAverage

	has_secure_password
	
	validates :username, uniqueness: true
	validates :username, length: { in: 3..15 }
	validates :password, length: { minimum: 4 }
	validate :password_complexity

	has_many :ratings, dependent: :destroy
	has_many :memberships

	def password_complexity
   		if (password =~ /[A-Z]/).blank? || (password =~ /[0-9]/).blank?
    		errors.add(:password, "must contain an uppercase letter and a number.")
    	end
	end

	def to_s
		"#{self.username}"
	end
end
