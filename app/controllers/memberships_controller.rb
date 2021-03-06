class MembershipsController < ApplicationController

  before_filter :authenticate, :only => [:new, :edit, :update, :destroy]
  before_filter :admin_user, :except => [:index, :purchase, :show]

  def index
    @title = "Memberships"
    @memberships = Membership.all
    @membership = Membership.new
    flash.now[:notice] = "Sorry, there are no memberships available at the moment" if @memberships.empty?
    respond_to do |format|
      format.html
      format.xml  { render :xml => @memberships }
    end
  end

  def show
    @membership = Membership.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @membership }
    end
  end

  def new
    @title = "New Membership"
    @membership = Membership.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @membership }
    end
  end

  def edit
    @membership = Membership.find(params[:id])
  end

  def create
    @membership = Membership.new(params[:membership])

    respond_to do |format|
      if @membership.save
        format.html { redirect_to(memberships_path, :notice => 'Membership was successfully created.') }
        format.xml  { render :xml => @membership, :status => :created, :location => @membership }
        format.js
      else
        @title = "New Membership"
        format.html { render :action => "new" }
        format.xml  { render :xml => @membership.errors, :status => :unprocessable_entity }
        format.js { render }
      end
    end
  end

  def update
    @membership = Membership.find(params[:id])

    respond_to do |format|
      if @membership.update_attributes(params[:membership])
        format.html { redirect_to(@membership, :notice => 'Membership was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @membership.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy

    respond_to do |format|
      format.html { redirect_to(memberships_url) }
      format.xml  { head :ok }
    end
  end

  def purchase

    respond_to do |format|
        if signed_in?
          	if current_user.has_subscription?
          	 flash[:info] = "You must cancel your current membership before purchasing another."
          	 format.html { redirect_to(current_user) }
             format.js
            else
              membership = Membership.find_by_id(params[:id])
			        current_user.create_subscription(:membership => membership)
              flash[:success] = "You have purchased the #{membership.title} membership!"
			        format.html { redirect_to(current_user) }
              format.js
            end
        else
          flash[:notice] = render_to_string(:partial => 'memberships/flash/one')
          format.html { redirect_to(signup_path) }
          format.js
		    end
    end

  end

end

