class ActivitiesController < ApplicationController

  before_filter :authenticate, :only => [:new, :edit, :update, :destroy, :booking]
  before_filter :admin_user, :except => [:index]


  def booking
    respond_to do |format|

        if current_user.has_subscription?
        	@activity = Activity.find(params[:id])
        	booking = Booking.create(:activity_id => @activity.id)
          flash[:success] = "You have successfully booked for #{@activity.title}"
          current_user.bookings << booking
          format.html { redirect_to current_user }
          format.js
        else
          flash[:notice] = render_to_string(:partial => 'activities/flash/one');
          format.html { redirect_to activities_path }
          format.js
        end
      end
  end

  def index
    @title = "Activities"
    @activity = Activity.new if signed_in? and current_user.admin?
    @activities = Activity.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activities }
    end
  end

  def show
    @activity = Activity.find(params[:id])
    @title = "Activity #{@activity.id}"

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @activity }
    end
  end

  def new
    @title = "New Activity"
    @activity = Activity.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @activity }
    end
  end

  def edit
    @title = "Edit Activity"
    @activity = Activity.find(params[:id])
  end

  def create
    @activity = Activity.new(params[:activity])

    respond_to do |format|
      if @activity.save
        format.html { redirect_to(@activity, :notice => 'Activity was successfully created.') }
        format.xml  { render :xml => @activity, :status => :created, :location => @activity }
        format.js
      else
        @title = "New Activity"
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @activity = Activity.find(params[:id])

    respond_to do |format|
      if @activity.update_attributes(params[:activity])
        format.html { redirect_to(@activity, :notice => 'Activity was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy

    respond_to do |format|
      format.html { redirect_to(activities_url) }
      format.xml  { head :ok }
    end
  end
end

