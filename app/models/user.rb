class User < ApplicationRecord
  has_many :attendances
  has_many :events, through: :attendances
  # Ensure phone input looks like a phone number
  phony_normalize :phone, default_country_code: 'US'
  validates :phone, phony_plausible: true

  validate :phone_or_email_present?
  validates_uniqueness_of :phone, :email

  def phone_or_email_present?
    if %w(phone email).all?{ |attr| self[attr].blank? }
      errors.add :base, "User must have at least phone or email"
    end
  end
end
