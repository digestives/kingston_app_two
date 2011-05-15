class SessionsController < ApplicationController

  def new
  	@title = "Sign up"
  end

  def create

    respond_to do |format|
		  if user = User.authenticate(params[:session][:email], params[:session][:password])
			  sign_in(user)
			  format.html { redirect_to(user.admin? ? admin_path : user, flash[:success] = 'Signed in') }
		  else
			  @title = "Sign up"
        flash[:notice] = 'Incorrect email/password combination'
			  format.html { render 'new' }
        format.js
		  end
    end

	end

	def destroy
		  sign_out
		  redirect_to(root_path, :notice => "Signed out.")
	end

end

