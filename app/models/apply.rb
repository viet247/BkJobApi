class Apply < ApplicationRecord
  belongs_to :user
  belongs_to :job

  # Define attach file
  has_one_attached :cv

  # Validations
  validates :full_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :user_id, uniqueness: { scope: :job_id }

  # Custom validation
  validate :must_be_attached_cv

  private

  def must_be_attached_cv
    unless cv.attached?
      errors.add(:cv, "must be attached!")
    end
  end
end
