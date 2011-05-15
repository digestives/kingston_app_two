# == Schema Information
# Schema version: 20110513235109
#
# Table name: posts
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  description :string(255)
#  published   :boolean
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Post < ActiveRecord::Base

	default_scope :order => 'posts.created_at DESC'

	belongs_to :user

	validates :user_id, :presence => true
  validates :title, :description, :presence => true
  validates :title, :length => { :maximum => 100 }


end

