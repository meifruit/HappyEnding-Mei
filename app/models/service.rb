class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :price, presence: true
  validates :title, presence: true
  validates :description, presence: true
  has_one_attached :photo

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
end
