class City < ApplicationRecord
  before_save :set_slug
  has_many :jobs, dependent: :nullfify
  validates :name, presence: true

  private
  def set_slug
    self.slug = name.parameterize if slug.blank?
  end
end
