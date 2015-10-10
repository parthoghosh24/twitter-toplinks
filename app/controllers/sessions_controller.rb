class SessionsController < ApplicationController

  # Creates user session
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:current_user_id]=@user.id
    redirect_to root_path
  end

  #Destroys user session
  def destroy
      session[:current_user_id]=nil
      current_user=nil
      # TweetsAnalytic.destroy_all
      # User.destroy_all
      # TweetUser.destroy_all
      # TweetUrlMap.destroy_all
      redirect_to root_path
  end

  protected

  def auth_hash
      request.env['omniauth.auth']
  end
end
