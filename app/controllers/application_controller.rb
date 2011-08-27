class ApplicationController < ActionController::Base
  protect_from_forgery
before_filter :set_time_zone
helper_method :current_user
  helper_method :user_signed_in?
  helper_method :correct_user?

  private
  def set_time_zone
  #Time.zone = ActiveSupport::TimeZone.new('my timezone', cookies[:timezone])
 # min = cookies[:timezone].to_i
  #Time.zone = ActiveSupport::TimeZone[-min.minutes]
  Time.zone = "New Delhi"
end
    def current_user
      begin
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
      rescue Mongoid::Errors::DocumentNotFound
        nil
      end
    end

    def user_signed_in?
      return true if current_user
    end

    def correct_user?
      @user = User.find(params[:id])
      unless current_user == @user
        redirect_to root_url, :alert => "Access denied."
      end
    end

    def authenticate_user!
      if !current_user
        redirect_to root_url, :alert => 'You need to sign in for access to this page.'
      end
    end
end
