# == Schema Information
#
# Table name: tweet_url_maps
#
#  id                  :integer          not null, primary key
#  tweets_analytics_id :integer
#  tweet_user_id       :integer
#  url                 :string
#  domain              :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class TweetUrlMap < ActiveRecord::Base
  belongs_to :TweetsAnalytic
  belongs_to :TweetUser

  def self.process_domains
        tweets = TweetsAnalytic.all
        tweets.each do |tweet|
           # 1) extract urls from tweet and  2) process domains for url 3) feed in table
           urls = URI.extract(tweet.tweet_text,['http','https'])
           if !urls.blank?
              urls.each do |url|
                TweetUrlMap.create!(tweets_analytics_id:tweet.id, url:url, domain:nil, tweet_user_id:tweet.tweet_user.id)
              end
           end
        end
  end

  def self.update_domains
       maps = TweetUrlMap.all
       maps.each do |map|
           domain = process_url(map.url)
           map.update!(domain:domain)
       end
  end

  private
  def self.process_url(raw_url)
       url = URI.parse(raw_url)
       res = Net::HTTP.get_response(url)
       while res.code!="200" and res.code=="301"
            url = URI.parse(res['location'])
            res = Net::HTTP.get_response(url)
       end
       if res.code == "200"
          return url.host
        else
           return "Unable to parse domain"
        end
  end
end
