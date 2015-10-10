# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string
#  uid        :string
#  name       :string
#  username   :string
#  image      :string
#  token      :string
#  secret     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  def self.find_or_create_from_auth_hash(auth_hash)
      user=where(provider:auth_hash.provider,uid:auth_hash.uid).first_or_create
      user.update(name:auth_hash.info.name, image:auth_hash.info.image, username:auth_hash.info.nickname,token:auth_hash.credentials.token, secret:auth_hash.credentials.secret)
      user
  end

  def twitter
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.secrets.twitter_api_key
      config.consumer_secret     = Rails.application.secrets.twitter_api_secret
      config.access_token        = token
      config.access_token_secret = secret
    end
  end

 # https://github.com/sferik/twitter/blob/master/examples/AllTweets.md- Fetching all tweets
  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def get_all_tweets
    collect_with_max_id do |max_id|
      options = {count: 200, include_rts: true}
      options[:max_id] = max_id unless max_id.nil?
      twitter.home_timeline( options)
    end
end


end
