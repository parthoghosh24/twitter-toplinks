# == Schema Information
#
# Table name: tweet_users
#
#  id            :integer          not null, primary key
#  name          :string
#  username      :string
#  profile_image :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  tweet_user_id :integer
#

class TweetUser < ActiveRecord::Base
    has_many :tweets_analytics
end
