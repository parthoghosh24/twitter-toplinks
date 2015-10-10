class ChangeTweetUserIdTypeInTweetUsers < ActiveRecord::Migration
  def change
      change_column :tweet_users, :tweet_user_id, :bigint
  end
end
