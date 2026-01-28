class Registration < ApplicationRecord
  enum :status, { pending: 0, confirmed: 1 }

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :expired, -> { where(status: :pending).where('expires_at < ?', Time.current) }
end
