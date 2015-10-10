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

  def self.domain_counts
       maps = TweetUrlMap.all
       domain_map={}
       maps.each do |map|
           domain = process_url(map.url)
           if domain_map.has_key?domain
                domain_map[domain]+=1
           else
                domain_map[domain]=1
           end
       end
       domain_map=domain_map.sort_by {|_key, value| value}
       domain_map.keys.reverse
  end

  private
  def self.process_url(raw_url)
       begin
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

       rescue Exception => e
            return "Unable to parse domain"
       end

  end
end
