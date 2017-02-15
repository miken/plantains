class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event
  attr_accessor :user_phone, :event_code
  validates_uniqueness_of :event_id, scope: :user_id

  def self.locate_code_and_phone(attendance_params)
    event = Event.find_by_code! attendance_params[:event_code]
    user_phone = attendance_params[:user_phone]
    user_phone_normalized = PhonyRails.normalize_number user_phone, default_country_code: 'US'
    user = User.find_or_create_by! phone: user_phone_normalized
    attendance = Attendance.new event_id: event.id,
                                user_id: user.id,
                                points_awarded: event.award_points
    attendance
  end
end