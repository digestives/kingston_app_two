require 'faker'

namespace :db do

  desc "Fill database with sample data"

  task :populate => :environment do

    Rake::Task['db:reset'].invoke
    make_admin
    make_users
    make_memberships
    make_posts
    make_activities
    make_subscriptions
    make_bookings

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

    User.create!(:forename => "Patrick",
		  						 :surname => "Magee",
		               :email => "patrick.magee@live.co.uk",
		               :password => "password",
		               :password_confirmation => "password",
		               :terms_of_service => "1")

    User.create!(:forename => "Paul",
		  						 :surname => "Laroy",
		               :email => "paul.laroy@live.co.uk",
		               :password => "password",
		               :password_confirmation => "password",
		               :terms_of_service => "1")

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

			title = Faker::Lorem.sentence(1)
			description = Faker::Lorem.paragraph(2)
      swimming = true
			sauna = [true, false].rand
			tennis = [true, false].rand
			guests = [1, 2, 4, 6, 8, 15, 30].rand
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

  def make_activities

    starts = Time.now + 2.days

		10.times do |n|

			title = Faker::Lorem.sentence(1)
			description = Faker::Lorem.paragraph(2)
      starts + 1.days
      limit = Activity::LIMIT.rand
      ends = starts + 30.minutes

			Activity.create!(:title => title,
										   :description => description,
                       :limit => limit,
                       :start => starts,
                       :end => ends)

		end
	end

  def make_bookings
		users = User.all
    users.each do |user|
      if user.has_subscription? && user.subscription.membership.swimming?
          @activities = Activity.find(:all)
            @activities.each do |activity|
              if activity.users.count < activity.limit
              	booking = Booking.create(:activity_id => activity.id)
                user.bookings << booking
              end
            end
      end
		end
	end

  def make_subscriptions

    users = User.all
    memberships = Membership.all

    users.each do |user|
        user.create_subscription(:membership_id => memberships.rand)
    end
  end
end

