class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, dependent: :destroy
  validates :price, presence: true
  validates :title, presence: true
  validates :description, presence: true
  has_many_attached :photos
end
