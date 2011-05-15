class BookingsController < ApplicationController

    # must be signed in for current_user
    before_filter :authenticate

  	def new
  	  respond_to do |format|

        if current_user.has_subscription?
        	activity = Activity.find(params[:id])
        	booking = Booking.create(:activity_id => activity.id)
          flash[:success] = "You have successfully booked for #{activity.title}"
          current_user.bookings << booking

          format.html { redirect_to current_user }
          format.js

        else
          flash[:notice] = render_to_string(:partial => 'bookings/one');

          format.html { redirect_to activities_path }
          format.js
        end
      end

  end


end

