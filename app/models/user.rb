class User < ApplicationRecord
  has_many :attendances
  has_many :events, through: :attendances

  # Ensure phone input looks like a phone number
  phony_normalize :phone, default_country_code: 'US'
  validates :phone, phony_plausible: true, uniqueness: true
end
