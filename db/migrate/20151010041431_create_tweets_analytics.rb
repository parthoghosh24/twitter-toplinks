class CreateTweetsAnalytics < ActiveRecord::Migration
  def change
    create_table :tweets_analytics do |t|
      t.integer :tweet_id
      t.string :tweet_user_name
      t.string :tweet_user_screename
      t.string :tweet_text
      t.string :tweet_user_profile_image

      t.timestamps null: false
    end
  end
end
