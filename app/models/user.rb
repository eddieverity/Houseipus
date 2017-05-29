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

end
