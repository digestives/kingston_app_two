# == Schema Information
# Schema version: 20110515002652
#
# Table name: activities
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :text
#  limit       :integer
#  start       :datetime
#  end         :datetime
#  created_at  :datetime
#  updated_at  :datetime
#

class Activity < ActiveRecord::Base

	LIMIT = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100]

	has_many :bookings
	has_many :users, :through => :bookings

	validates :limit, :presence => true, :inclusion => { :in => LIMIT }, :allow_blank => false
  validates :start, :presence => true, :timeliness => { :on => :create, :on_or_after => Time.current }
	validates :end, :presence => true, :timeliness => { :after => :start }

end

