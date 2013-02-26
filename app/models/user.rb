class User < ActiveRecord::Base
  # attr_accessible :title, :body

  def self.find_friends(user_id)

  	friends = User.find(:all,
  						:conditions => ['id != (?)', user_id])

  end
end
