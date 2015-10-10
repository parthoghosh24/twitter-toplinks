class RenameTweetUserToTweetUserIdInTweetUrlMaps < ActiveRecord::Migration
  def change
      rename_column :tweet_url_maps, :tweet_user, :tweet_user_id
  end
end
