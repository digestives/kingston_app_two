# == Schema Information
# Schema version: 20110513235109
#
# Table name: memberships
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :string(255)
#  swimming    :boolean
#  tennis      :boolean
#  sauna       :boolean
#  guests      :integer
#  price       :decimal(, )
#  created_at  :datetime
#  updated_at  :datetime
#

class Membership < ActiveRecord::Base

  has_many :users, :through => :subscriptions

  default_scope :order => 'memberships.created_at DESC'

	NUM_GUESTS_ALLOWED = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]

  attr_accessible :swimming, :sauna, :tennis, :title, :description, :price, :guests

	validates :title, :presence => true, :length => { :maximum => 150 }
	validates :description, :presence => true
  validates :swimming, :inclusion => { :in => [true], :message => "must be granted if tennis or sauna is not" }, :if => lambda { |m| !m.tennis && !m.sauna }
	validates :price, :presence => true
	validates :guests, :allow_blank => true, :numericality => true, :inclusion => { :in => NUM_GUESTS_ALLOWED }

end

