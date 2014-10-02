class User < ActiveRecord::Base
  before_save {email.downcase!}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  #validates_format_of :email,with: VALID_EMAIL_REGEX, message: "Niepoprawny email!" 
  #validates_presence_of :email, message: "Proszę podaj swój email."
  #validates_uniqueness_of :email, message: "Ten email już istnieje!"
  validates :email, format:   {with: VALID_EMAIL_REGEX, message: "Niepoprawny email!"},
                    uniqueness: {case_sensitive: false, message: "Ten email już istnieje!"}
end
