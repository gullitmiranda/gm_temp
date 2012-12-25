class ContactUs::ContactMailer < ActionMailer::Base
  def contact_email(contact)
    @contact = contact
    
    from = ContactUs.require_name ? "#{@contact.name} <#{@contact.email}>" : @contact.email
    
    mail :from    => (ContactUs.mailer_from || from),
         :reply_to => @contact.email,
         :subject => (ContactUs.require_subject ? @contact.subject : t('contact_us.contact_mailer.contact_email.subject', :email => @contact.email)),
         :to      => ContactUs.mailer_to
  end
end
