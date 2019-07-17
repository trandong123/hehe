class UserMailer < ApplicationMailer
  def account_activation email
    @email = email
    @greeting = t ".hi"
    mail to:  @email[:mail], subject: t(".activate")
  end
end
