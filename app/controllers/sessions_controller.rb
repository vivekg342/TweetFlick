class SessionsController < ApplicationController

def check
  unless !user_signed_in?
    result={:success =>  "true"}
  else
        result={:success =>  "false"}
  end
    respond_to do |format|
format.js {render :json => result}
end
end
  def create
  auth = request.env["omniauth.auth"]
  user = User.where(:provider => auth['provider'],
                    :uid => auth['uid']).first || User.create_with_omniauth(auth)
  session[:user_id] = user.id
  redirect_to root_url, :notice => "Signed in!"
end
def new
  redirect_to '/auth/twitter'
end
def destroy
  session[:user_id] = nil
  redirect_to root_url, :notice => 'Signed out!'
end
def failure
  redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
end
end
