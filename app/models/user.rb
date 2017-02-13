class User < ApplicationRecord
  has_many :attendances
  has_many :events, through: :attendances

  validate :phone_or_email_present?

  # Ensure phone input looks like a phone number
  phony_normalize :phone, default_country_code: 'US'
  validates :phone, phony_plausible: true, uniqueness: true

  def phone_or_email_present?
    if %w(phone email).all?{ |attr| self[attr].blank? }
      errors.add :base, "User must have at least phone or email"
    end
  end
end
