# == Schema Information
# Schema version: 20110514134542
#
# Table name: subscriptions
#
#  id            :integer         not null, primary key
#  user_id       :integer
#  membership_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Subscription < ActiveRecord::Base

  belongs_to :user
  belongs_to :membership

	validates :user_id, :presence => true
	validates :membership_id, :presence => true

end

