class CreateTweetUrlMaps < ActiveRecord::Migration
  def change
    create_table :tweet_url_maps do |t|
      t.integer :tweets_analytics_id
      t.integer :tweet_user
      t.string :url
      t.string :domain

      t.timestamps null: false
    end
  end
end
