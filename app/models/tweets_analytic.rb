# == Schema Information
#
# Table name: tweets_analytics
#
#  id            :integer          not null, primary key
#  tweet_id      :integer
#  tweet_text    :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  tweet_user_id :integer
#

class TweetsAnalytic < ActiveRecord::Base
      belongs_to :tweet_user

      def self.import(tweets, current_user=nil)
           if current_user
              tweets= current_user.get_all_tweets
              tweets.each do |tweet|
                  if (tweet.text.include? "http" or tweet.text.include? "https") and !tweet.text.include?"twitter.com"# better way would have been to use regex something like http(s)
                     process_tweet(tweet) # Here we are processing tweet to store it in db
                  end
              end
           end

      end

      private

      def self.process_tweet(tweet)
          #create or fetch a tweet user
          if !TweetUser.exists?(tweet_user_id:tweet.user.id)
              tweet_user = TweetUser.create!( name:tweet.user.name,username:tweet.user.screen_name,profile_image:tweet.user.profile_image_url,tweet_user_id:tweet.user.id)
          else
              tweet_user = TweetUser.find_by(tweet_user_id:tweet.user.id)
          end

          #safe checking if tweet exist or not
          if !TweetsAnalytic.exists?(tweet_id:tweet.id)
              tweet = TweetsAnalytic.create!(tweet_id:tweet.id, tweet_text:tweet.text, tweet_user_id:tweet_user.id)
          end
      end
end
