class ExampleMailer < ApplicationMailer
  default from: 'hey@andrealvarez.com'

  def sample_email(buyer,link,seller,billing)
   @buyer = buyer
   @link = link
   @seller = seller
   @billing = billing
   mail(to: @buyer.email, subject: 'Mail de Kobra')
  end

end
