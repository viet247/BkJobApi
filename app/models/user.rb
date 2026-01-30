class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  attr_accessor :reset_token
  has_one_attached :my_cv
  
  has_many :applies, dependent: :destroy
  has_many :jobs_applied, through: :applies, source: :job
  has_many :favorites, dependent: :destroy
  has_many :favorite_jobs, through: :favorites, source: :job
  has_many :histories, dependent: :destroy
  has_one :company

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :login_id, uniqueness: { allow_nil: true }
  validates :login_id, presence: true, if: :admin?

  # define: 1 is candidate, 2 is admin
  enum :role, { candidate: 1, admin: 2 }
  
  def create_reset_digest
    # tao chuoi ngau nhien
    self.reset_token = SecureRandom.urlsafe_base64
    # ma hoa
    hashed_token = BCrypt::Password.create(reset_token)
    # luu vao db
    update_columns(reset_digest: hashed_token, reset_sent_at: Time.zone.now)
  end

  def authenticated_reset_token?(token)
    return false if reset_digest.nil?

    BCrypt::Password.new(reset_digest).is_password?(token)
  end

  def password_reset_expired?
    Time.current > reset_sent_at + 1.day
  end
end
