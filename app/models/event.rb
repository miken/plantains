class Event < ApplicationRecord
  has_many :attendances
  has_many :users, through: :attendances
  attr_accessor :user_id
end
