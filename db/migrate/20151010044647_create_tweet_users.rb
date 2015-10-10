class CreateTweetUsers < ActiveRecord::Migration
  def change
    create_table :tweet_users do |t|
      t.string :name
      t.string :username
      t.string :profile_image

      t.timestamps null: false
    end
  end
end
