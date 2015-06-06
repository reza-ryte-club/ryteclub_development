class User < ActiveRecord::Base
  TEMP_EMAIL_PREFIX = 'chnage@me'
  TEMP_EMAIL_REGEX = /\Achnage@me/


  after_create :send_welcome_email
  before_create :set_default_user_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_many :tales
  has_many :plots
  has_one :bio
  acts_as_follower
  acts_as_followable
  acts_as_liker
  
  #include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
   #      :recoverable, :rememberable, :trackable # :validatable

  


  validates_uniqueness_of :email, :without => TEMP_EMAIL_REGEX, on: :update, :case_sensitive => false, :if => :email_changed?
  #validates_uniqueness_of :username, :case_sensitive => true, :allow_blank => false
  #validates_format_of :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?
  #validates_presence_of   :password, :on=>:create
  #validates_confirmation_of   :password, :on=>:create
  #validates_length_of :password, :within => Devise.password_length, :allow_blank => true
  #validates_presence_of :firstname
  #validates_presence_of :lastname
  #validates_presence_of :username

  ## Database authenticatable
  #field :email,              type: String, default: ""
  #field :encrypted_password, type: String, default: ""

  ## Recoverable
  #field :reset_password_token,   type: String
  #field :reset_password_sent_at, type: Time

  ## Rememberable
  #field :remember_created_at, type: Time

  ## Trackable
  #field :sign_in_count,      type: Integer, default: 0
  #field :current_sign_in_at, type: Time
  #field :last_sign_in_at,    type: Time
  #field :current_sign_in_ip, type: String
  #field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  

 # Mail delivery function called here to send welcome email
  def send_welcome_email
    NotifyMailer.signup_confirmation(self).deliver
  end
 # email format of users
  def formated_email
   "#{firstname} <#{email}>"
  end
  def to_s
    "#{firstname}"
  end
  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_or_create_by(uid: auth.uid, provider: auth.provider)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = signed_in_resource ? signed_in_resource : identity.user

    # Create the user if needed
    if user.nil?

      # Get the existing user by email if the provider gives us a verified email.
      # If no verified email was provided we assign a temporary email and ask the
      # user to verify it on the next step via UsersController.finish_signup
      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email  
      
      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          firstname: auth.extra.raw_info.name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
       # user.skip_confirmation!
        user.save!
      end
    end 
    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end
  # def self.from_omniauth(auth)
  #   where(auth.slice(:provider, :uid)).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.username = auth.info.nickname
  #   end
  # end

  # def self.new_with_session(params, session)
  #   if session["devise.user_attributes"]
  #     new(session["devise.user_attributes"], without_protection: true) do |user|
  #       user.attributes = params
  #       user.valid?
  #     end
  #   else
  #     super
  #   end
  # end


  def facebook
    #@facebook ||= Koala::Facebook::API.new(CAACEdEose0cBAJZAKJldF9UQAEIDgKipXRdCZAAyuoCmjoFAnflFf35ZCABKal1ywBnP1QmMCrTH2iXAZC3iIv1wxvVQMomlFOOAr6RVVZAr48nwOU06hPZCFFI65Nr6ly3Y4wRXRe1C0YQxPAQspS2WRuFK2fsclkcY2cxB8DZBNUrPmMtwk6x1ZBM77p4WpnrPY0oghKZA13nZBZAg0QxYflfEaYZC4vlWiq0ZD)
    #to get the access token the following url can be used
    #https://developers.facebook.com/tools/explorer/878916972138133/?method=GET&path=me%3Ffields%3Did%2Cname&version=v2.2
  end





  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def admin?
    if role.name.present? and role.name == 'admin'
      true
    else
      false
    end
  end

  def writer?
    if role.name.present? and role.name == 'writer'
     return true
    else
     return false 
    end
  end

  protected
    def set_default_user_role
      self.role ||= Role.find_by_name('writer')
    end
end
