class Job < ApplicationRecord
    has_many :applies, dependent: :destroy
    has_many :users, through: :applies
    has_many :favorites, dependent: :destroy
    has_many :favorite_users, through: :favorites, source: :user
    has_many :histories, dependent: :destroy

    belongs_to :industry
    belongs_to :position, optional: true
    belongs_to :city
    belongs_to :company

    validates :title, presence: true
    validates :salary, numericality: { greater_than: 0 }
end
