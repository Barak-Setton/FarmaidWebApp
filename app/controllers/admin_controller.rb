class AdminController < ApplicationController
  skip_before_action :verify_authenticity_token  

	def index
		@msg = params[:message]
	end

	def check_login

		if params[:login_info][:name] == "Aslam"
			admin = Teacher.find_by(name: params[:login_info][:name])
			password = admin.password
		end
		if admin.blank?
			redirect_to :action => 'index', message: 'user name does not exist'
		elsif password == params[:login_info][:password]
			session[:admin_id] = admin.id
			redirect_to url_for(:action => 'index', :controller => "institute")
		else
			redirect_to :action => 'index', message: 'access denied'
		end
	end

	def add
		if session[:admin_id] != nil
			@institute = Institute.new
		else
			redirect_to :action => 'index'
		end
	end
end