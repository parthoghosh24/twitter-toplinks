class AnalyticsController < ApplicationController

  def index

  end

  def fetch_link_tweets
    begin
        TweetsAnalytic.import(current_user.get_all_tweets,current_user) if current_user and TweetsAnalytic.count == 0 # run if Empty table
        tweets = TweetsAnalytic.all
        tweetsJson=[]
        tweets.each do |tweet|
            tweetJson=tweet.as_json
            tweetJson["user"]=TweetUser.find(tweet.tweet_user_id).as_json
            tweetsJson.push(tweetJson)
        end
        render json:{tweets:tweetsJson}
    rescue Twitter::Error::TooManyRequests => error
        sleep error.rate_limit.reset_in + 1
        retry
    end
  end

  def top_user
      TweetUrlMap.process_domains if current_user and TweetUrlMap.count == 0 # run if Empty table
      top_user = TweetUrlMap.select("tweet_user_id,count(*) as tc").group("tweet_user_id").order("tc desc").first
      top_user = TweetUser.find(top_user.tweet_user_id)
      top_user_json=top_user.as_json
      render json:{top_user:top_user_json}
  end

  def top_domains
      # TweetUrlMap.update_domains if  TweetUrlMap.count>0
      top_domains_plucks = TweetUrlMap.select("domain,count(*) as tc").group("domain").order("tc desc")
      top_domains=[]
      top_domains_plucks.each do |domain_obj|
          top_domains.push(domain_obj.domain)
      end
      render json:{domains:top_domains}
  end
end
