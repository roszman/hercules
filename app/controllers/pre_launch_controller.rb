class PreLaunchController < ApplicationController
  layout  "blank_layout"
  def index
    @user = User.new
  end
  def subscribe
    user = User.create params.require(:user).permit(:email)
  end   

end
