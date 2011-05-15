module SessionsHelper

  # set the current user
  def current_user=(user)
		@current_user = user
	end

  # compare current user with another user
	def current_user?(user)
    current_user == user
  end

  # return the instance of the current user
  def current_user
		@current_user ||= User.find_by_id(session[:user_id])
	end

	def sign_in(user)
		session[:user_id] = user.id
		self.current_user = user # set the current user
	end

	def sign_out
		session[:user_id] = nil
    self.current_user = nil
	end

	def signed_in?
	  !current_user.nil?
	end

	def deny_access
	  flash[:notice] = 'Please sign in to access that page'
    redirect_to(signin_path)
  end

  def authenticate
    deny_access unless signed_in?
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end

