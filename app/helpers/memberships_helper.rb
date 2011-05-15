module MembershipsHelper


  def display_privilege(privilege, membership)
    # checks if its true or false
    if privilege
      # if its true, or exists, we check if its a value
      if privilege == membership.guests && privilege > 0
        privilege
      elsif privilege == membership.guests && privilege < 1
        image_tag("/stylesheets/blueprint/plugins/buttons/icons/cross.png")
      else
        image_tag("/stylesheets/blueprint/plugins/buttons/icons/tick.png")
      end
    else
      image_tag("/stylesheets/blueprint/plugins/buttons/icons/cross.png")
    end
  end

end

