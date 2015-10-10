class AddTweetUserIdToTweetsAnalytics < ActiveRecord::Migration
  def change
    add_column :tweets_analytics, :tweet_user_id, :integer
  end
end
