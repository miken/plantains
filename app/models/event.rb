class Event < ApplicationRecord
  has_many :attendances
  has_many :users, through: :attendances
  validates :name, presence: true
  validates :code, uniqueness: true
end
