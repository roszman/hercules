class PreLaunchController < ApplicationController
  layout  "pre_launch"
  def index
    @user = User.new
  end
  def subscribe
      user = User.create(subscription_params)
      if user.valid?
        #TODO stringi do słowników - ror guides I18n
        flash.now[:success] = 'Dziękujemy! Niedługo poznasz więcej szczegółów!'
      else
          #TODO słowniki
          flash.now[:errors] = user.errors 
          render action: 'index'
      end 
  end   

  private

  def subscription_params
    params.permit(:email)
  end

end
