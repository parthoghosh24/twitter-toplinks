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

require 'rails_helper'

RSpec.describe TweetUser, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
