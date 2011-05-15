class UsersController < ApplicationController

  before_filter :authenticate, :except => [:show, :new]
  before_filter :admin_user, :except => [:show, :new]

  def index
    @title = "Users"
    @users = User.all
    @user = User.new
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def admin
    @title = "Admin"
  end


  def new
    @title = "Sign up"
    @users = User.find(:all, :order => "id desc", :limit => 5)
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(root_path, :notice => 'You should receive a confirmation email.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
        format.js
      else
        @title = "Sign up"
        @users = User.find(:all, :order => "id desc", :limit => 5)
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        @title = "Edit"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
      format.js
    end
  end
end

