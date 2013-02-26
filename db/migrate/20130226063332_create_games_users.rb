class CreateGamesUsers < ActiveRecord::Migration
  def change
    create_table :games_users do |t|

      t.timestamps
    end
  end
end
