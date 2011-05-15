# == Schema Information
# Schema version: 20110515175902
#
# Table name: bookings
#
#  id          :integer         not null, primary key
#  user_id     :integer
#  activity_id :integer
#  guests      :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Booking < ActiveRecord::Base

  belongs_to :user
  belongs_to :activity

  validates :user_id,     :presence => true
  validates :activity_id, :presence => true


end

