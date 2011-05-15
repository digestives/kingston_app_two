module ActivitiesHelper

   def display_color(current, maximum)
      if current >= maximum
        "red;"
      elsif current > maximum - (maximum * 0.15)
        "orange;"
      else
        "green;"
      end
   end

  def not_booked(activity)
    current_user.bookings.each do |booking|
      if booking.activity == activity
          return false
      end
    end
  end

end

