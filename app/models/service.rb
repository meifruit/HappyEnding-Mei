class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, dependent: :destroy
  validates :price, presence: true
  validates :title, presence: true
  validates :description, presence: true

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [:title, :description, :price],
    associated_against: {
      user: [:name]
  },
    using: {
      tsearch: { prefix: true }
  }
  scope :filter_by_price, lambda { |min_price, max_price|
    where(price: min_price..max_price)
  }

  has_many_attached :photos

end
