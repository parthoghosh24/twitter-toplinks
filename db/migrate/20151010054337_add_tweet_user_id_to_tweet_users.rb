class AddTweetUserIdToTweetUsers < ActiveRecord::Migration
  def change
    add_column :tweet_users, :tweet_user_id, :integer
  end
end
