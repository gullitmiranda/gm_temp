class ContactUs::Contact
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :mailer_to, :email, :phone, :message, :name, :subject

  validates :email,   :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i },
                      :presence => true
  validates :message, :presence => true

  validates :name,    :presence => ContactUs.require_name || false
  validates :subject, :presence => ContactUs.require_subject || false

  def initialize(attributes = {})
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
  end

  def save
    if self.valid?
      ContactUs::ContactMailer.contact_email(self).deliver
      return true
    end
    return false
  end
  
  def persisted?
    false
  end
end
