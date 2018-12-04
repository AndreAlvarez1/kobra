class ExampleMailer < ApplicationMailer
  default from: 'hey@andrealvarez.com'

  def sample_email(user,link,seller,billing)
   @user = user
   @link = link
   @seller = seller
   @billing = billing
   @texto = "textos textos"
   mail(to: @user.email, subject: 'Mail de Kobra')
  end

end
