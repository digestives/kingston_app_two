# == Schema Information
# Schema version: 20110515002652
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  forename           :string(255)
#  surname            :string(255)
#  encrypted_password :string(255)
#  salt               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  admin              :boolean
#

require 'digest'

class User < ActiveRecord::Base

  has_many :posts
	has_one :subscription
	has_one :membership, :through => :subscription

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  attr_accessor :password, :terms_of_service

  attr_accessible :forename, :surname, :password, :password_confirmation, :email, :terms_of_service

  validates :forename, :surname, :allow_blank => false, :length => { :within => 2..15 }
  validates :terms_of_service, :acceptance => true
  validates :password, :presence => true, :confirmation => true, :length => { :within => 5..30 }, :if => :password_required?
  validates :email, :uniqueness => { :case_sensitive => false }, :format => { :with => EMAIL_REGEX , :message => "is not a valid email address" }

	before_save :encrypt_password
	before_update :password_required?

	def full_name
		[forename, surname].join(' ')
	end

	def has_password?(submitted_password)
		self.encrypted_password == encrypt(submitted_password)
	end

	def has_subscription?
    !self.subscription.nil?
	end

	def can_book?
	  if self.has_subscription?
	   self.subscription.membership.swimming?
    end
	end

  # check sessions helper
	def self.authenticate(email, submitted_password)
		if user = find_by_email(email)
			if user.has_password?(submitted_password)
				return user
			end
		end
	end

  def password_required?
		self.encrypted_password.blank? || !password.blank?
	end

	private

	def encrypt_password
		self.salt = make_salt if new_record?
		self.encrypted_password = encrypt(password) # the virtual attribute
	end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

	def make_salt
		secure_hash("#{Time.now.utc}--#{rand}")
	end

	def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end


end

