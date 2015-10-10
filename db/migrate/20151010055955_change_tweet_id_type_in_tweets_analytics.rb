class ChangeTweetIdTypeInTweetsAnalytics < ActiveRecord::Migration
  def change
    change_column :tweets_analytics, :tweet_id, :bigint
  end
end
