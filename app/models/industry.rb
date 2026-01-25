class Industry < ApplicationRecord
  has_many :jobs, dependent: :nullify
  validates :name, presence: true
end
