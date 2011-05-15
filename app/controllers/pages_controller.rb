class PagesController < ApplicationController

  def index
    @title = "Home"
    @posts = Post.find(:all, :limit => 5)
  end

  def about
    @title = "About"
  end

  def contact
    @title = "Contact"
  end

end

