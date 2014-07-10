require 'mandrill'

class Guest < ActiveRecord::Base
  belongs_to :product

  attr_accessor :total_guests

  validates :name, presence: true

  after_save :send_email, if: -> (guest) { guest.email.present? && guest.email_message_changed? }

  def send_email
    mandrill = Mandrill::API.new

    message = {
      subject: 'Presente de Casamento',
      from_email: email,
      from_name: name,
      text: email_message,
      to: [
        { email: 'brunoferreirapinto@gmail.com', name: 'Bruno' },
        { email: 'bianca_correia@hotmail.com', name: 'Bianca' }
      ]
    }

    mandrill.messages.send message
  end
end
