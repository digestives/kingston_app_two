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

end

