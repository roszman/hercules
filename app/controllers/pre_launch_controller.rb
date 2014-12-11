class PreLaunchController < ApplicationController
  layout  "pre_launch"
  def index
    @user = User.new
  end
  def subscribe
      user = User.create(subscription_params)
      if user.valid?
        #TODO stringi do słowników - ror guides I18n
        flash.now[:success] = 'Dziękujemy :)<br/>Niedługo poznasz więcej szczegółów!'.html_safe
        logger.tagged('PRE_LAUNCH'){logger.info { "New user #{user.email}"}}
      else
        #TODO słowniki
        flash.now[:errors] = user.errors
        logger.tagged('PRE_LAUNCH'){logger.warn { "Invalid user #{user.email}"}}
        render action: 'index'
      end 
  end   

  private

  def subscription_params
    params.permit(:email)
  end

end
