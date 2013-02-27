class GamesUser < ActiveRecord::Base
  attr_accessible :game_id, :user_id
  belongs_to :user
  belongs_to :game
end
