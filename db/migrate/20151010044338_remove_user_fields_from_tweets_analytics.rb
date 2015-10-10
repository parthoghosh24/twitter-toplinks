class RemoveUserFieldsFromTweetsAnalytics < ActiveRecord::Migration
  def change
    remove_column :tweets_analytics, :tweet_user_name, :string
    remove_column :tweets_analytics, :tweet_user_screename, :string
    remove_column :tweets_analytics, :tweet_user_profile_image, :string
  end
end
