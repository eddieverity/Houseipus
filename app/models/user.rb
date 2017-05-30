class User < ApplicationRecord
  has_secure_password
  has_many :messages_sent, class_name: 'Message', foreign_key: :sender_id
  has_many :receivers, -> { select('users.*, messages.content') }, through: :messages_sent, source: :receiver


  has_many :messages_received, class_name: 'Message', foreign_key: :receiver_id
  has_many :senders, -> { select('users.*, messages.content') }, through: :messages_received, source: :sender

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  
  before_save :email_lowercase

  def email_lowercase
    email.downcase!
  end

  def contacts
    contact_array = []
    self.senders.each do |s|

      contact_array.push(s.id) unless contact_array.include?(s.id)
    end
    self.receivers.each do |r|
      contact_array.push(r.id) unless contact_array.include?(r.id)
    end


    return contact_array
  end

end
