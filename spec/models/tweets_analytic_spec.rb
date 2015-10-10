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

require 'rails_helper'

RSpec.describe TweetsAnalytic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
