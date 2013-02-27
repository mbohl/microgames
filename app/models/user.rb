class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password

  #map for games_users
  has_many :games_users
  has_many :games, :through => :games_users

  def self.find_friends(user_id)

  	friends = User.find(:all,
  						:conditions => ['id != (?)', user_id])

  end
end
