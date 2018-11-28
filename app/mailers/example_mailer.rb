class ExampleMailer < ApplicationMailer
  default from: 'hey@andrealvarez.com'

  def sample_email(user,link)
   @user = user
   @texto = "textos textos"
   @link = link
   mail(to: @user.email, subject: 'Mail de Kobra')
  end

end
