class UsersController < ApplicationController

  def index
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.ip = request.env['REMOTE_ADDR']
    if @user.save
      flash[:notice] = "<p>Thanks for registering your interest!</p>"
      if ENV['RAILS_ENV'] == 'production'
        uri = URI.parse('http://bench.createsend.com/t/r/s/jrtijl/')
        Net::HTTP.post_form(uri, {
          'cm-name' => @user.name, 
	      'cm-jrtijl-jrtijl' => @user.email
        })
      end
      redirect_to users_path
    else
      render :action => 'index'
    end
  end

end
