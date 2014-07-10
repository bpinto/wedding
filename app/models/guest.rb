require 'mandrill'

class Guest < ActiveRecord::Base
  belongs_to :product

  attr_accessor :total_guests

  validates :name, presence: true

  after_save :send_notification_email, if: -> (guest) { guest.email.present? && guest.email_message_changed? }
  after_save :send_thanks_email, if: -> (guest) { guest.email.present? && guest.product.present? }

  def send_notification_email
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

  def send_thanks_email
    mandrill = Mandrill::API.new

    message = {
      subject: 'Agradecimento - Bianca e Bruno',
      from_email: 'bianca_correia@hotmail.com',
      from_name: 'Bianca e Bruno',
      text: 'Obrigado pelo carinho e por participar desse momento tão importante em nossas vidas. Adoramos o presente!',
      to: [
        { email: email, name: name }
      ]
    }

    mandrill.messages.send message
  end
end
