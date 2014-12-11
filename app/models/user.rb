class User < ActiveRecord::Base
  before_save  :user_not_exists?, :email_downcase! 
  after_create :user_not_exists?, :subscribe_to_mailing_list 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  #validates_format_of :email,with: VALID_EMAIL_REGEX, message: "Niepoprawny email!" 
  #validates_presence_of :email, message: "Proszę podaj swój email."
  #validates_uniqueness_of :email, message: "Ten email już istnieje!"
  validates :email, format:   {with: VALID_EMAIL_REGEX, message: "Upewnij się, czy podany email jest prawidłowy."}
               #     uniqueness: {case_sensitive: false, message: "Mamy już Twój email."}

  private
  def subscribe_to_mailing_list testing=false
    return true if(Rails.env.test? && !testing) 
    list_id = ENV['MAILCHIMP_LIST_ID']

    begin
    response = Rails.configuration.mailchimp.lists.subscribe({
      id: list_id,
      email: {email: email},
      double_optin: false
    })
    rescue Gibbon::MailChimpError => e
      logger.tagged( "MAILCHIMP" ){ logger.error { "Error while subscribing user to Mailchimp: messge: #{e.message}, code #{e.code}"} }
    end
    response
  end

  def user_not_exists?
    answer = !User.exists?(email: email.downcase)
    if(!answer) logger.tagged('MAILCHIMP'){logger.warn {"User is subsribed on list but not in database. email: #{user.email}"
  end

  def email_downcase!
    email.downcase!
  end

end
