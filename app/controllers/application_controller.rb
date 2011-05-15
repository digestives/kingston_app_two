class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  # http://stackoverflow.com/questions/5096115/rails-3-app-doesnt-redirect-after-ajax-form-submission
  # This is for non ajax redirect requests
  def redirect_to(options = {}, response_status = {})
    if request.xhr?
      render(:update) {|page| page.redirect_to(options)}
    else
      super(options, response_status)
    end
  end

end

