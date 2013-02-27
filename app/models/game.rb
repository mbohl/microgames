class Game < ActiveRecord::Base
	attr_accessible :type, :turn, :last_turn, :state

	#map to users via games_user
	has_many :games_users, :dependent => :destroy
	has_many :users, :through => :games_users

end
