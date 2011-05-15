require 'faker'

namespace :db do

  desc "Fill database with sample data"

  task :populate => :environment do

    Rake::Task['db:reset'].invoke
    make_admin
    make_users
    make_memberships
    make_posts

  end

  def make_admin

		terms_of_service = "1"
		password  = "password"

    admin = User.create!(:forename => "admin", :surname => "user", :email => "admin@email.com", :password => password, :password_confirmation => password, :terms_of_service => terms_of_service)
    admin.toggle!(:admin)

    3.times do |n|
      forename  = Faker::Name.first_name
		  surname 	= Faker::Name.last_name
		  email     = Faker::Internet.email([forename, surname].join("."))
		  terms_of_service = "1"
		  password  = "password"
      admin = User.create!(:forename => forename, :surname => surname, :email => email, :password => password, :password_confirmation => password, :terms_of_service => terms_of_service)
      admin.toggle!(:admin)
    end

  end

  def make_users

		50.times do |n|
		  forename  = Faker::Name.first_name
		  surname 	= Faker::Name.last_name
		  email     = Faker::Internet.email([forename, surname].join("."))
		  terms_of_service = "1"
		  password  = "password"

		  User.create!(:forename => forename,
		  						 :surname => surname,
		               :email => email,
		               :password => password,
		               :password_confirmation => password,
		               :terms_of_service => terms_of_service)
		end

	end

	def make_posts

		users = User.find_all_by_admin(true)
    users.each do |user|
		  5.times do
			  title = Faker::Lorem.words(2)
			  description  = Faker::Lorem.paragraph(2)
			  published = true
			  user.posts.create!(:title => title, :description => description, :published => published)
      end
		end
	end

	def make_memberships

		5.times do |n|

			title = Faker::Lorem.words(2)
			description = Faker::Lorem.paragraph(1)
      swimming = true
			sauna = [true, false].rand
			tennis = [true, false].rand
			guests = rand(5)
			# Random number, then rounded with a precision of two from the decimal
			price = (rand * 50).round(2)

			Membership.create!(:title => title,
												 :description => description,
												 :sauna => sauna,
												 :swimming => swimming,
												 :tennis => tennis,
												 :guests => guests,
												 :price => price)
		end
	end

end

