class Position < ApplicationRecord
  has_many :jobs, dependent: :nullify

  validates :title, presence: true
end
