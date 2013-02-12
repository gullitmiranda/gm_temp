class ConfirmationMailer < ActionMailer::Base
  default from: 'not-reply@requestdev.com.br'
  default subject: ''
  default content_type: 'text/plain'

  def send_confirmation_mail(email = nil)
    if email
      mail to: email, subject: 'Bem-vindo ao Rdcms.'
    else
      do_not_deliver!
    end
  end
end

# http://stackoverflow.com/questions/6550809/rails-3-how-to-abort-delivery-method-in-actionmailer

module ActionMailer
  class Base
    # A simple way to short circuit the delivery of an email from within
    # deliver_* methods defined in ActionMailer::Base subclases.
    def do_not_deliver!
      raise AbortDeliveryError
    end

    def process(*args)
      begin
        super *args
      rescue AbortDeliveryError
        self.message = BlackholeMailMessage
      end
    end
  end
end

class AbortDeliveryError < StandardError
end

class BlackholeMailMessage < Mail::Message
  def self.deliver
    false
  end
end
