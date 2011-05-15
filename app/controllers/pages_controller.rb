class PagesController < ApplicationController

  def index
  end

  def about
    @title = "About"
  end

  def contact
    @title = "Contact"
  end

end

