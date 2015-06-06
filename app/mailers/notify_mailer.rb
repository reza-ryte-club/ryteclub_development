class NotifyMailer < ActionMailer::Base
  
  default from: "Ryte Club <admin@ryte.club>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notify_mailer.signup_confirmation.subject
  #
  def signup_confirmation(user)
    @user = user

    mail to: @user.formated_email, subject: "Welcome to Ryte Club"
  end


  def sharing_invitation(email,tale_id)
    
    @author = Tale.where(id: tale_id).pluck(:user_id)
    @authorName = User.where(id: @author[0]).pluck(:firstname)
    @storyName = Tale.where(id: tale_id).pluck(:title)
    @storyLink = "http://ryte.club/tales/"+tale_id.to_s
    @subjectText = @authorName[0] + " has invited you to contribute to the content."
    @extensionLink = "http://ryte.club/plots/new?tale_id="+ tale_id.to_s
    mail to: email, subject: @subjectText
  end



end
