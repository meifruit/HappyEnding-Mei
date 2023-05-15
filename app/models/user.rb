class User < ApplicationRecord
  has_many :bookings
  has_many :services
  has_many :bookings_as_owner, through: :services, source: :bookings
  validates :name, presence: true
  validates :email, uniqueness: true, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end