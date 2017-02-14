class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event
  attr_accessor :user_phone, :event_code
end