class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event
  attr_accessor :user_phone, :event_code
  validates :user_id, uniqueness: { scope: :event_id, message: "has checked in with this number. Please try again." }

  validate :check_valid_event

  def check_valid_event
    errors.add(:event, "code not found. Please try again.") if event_id.nil?
  end

  def self.locate_code_and_phone(attendance_params)
    event = Event.find_by_code attendance_params[:event_code]
    if event.nil?
      attendance = Attendance.new
    else
      user_phone = attendance_params[:user_phone]
      user_phone_normalized = PhonyRails.normalize_number user_phone, default_country_code: 'US'
      user = User.find_or_create_by phone: user_phone_normalized
      attendance = Attendance.new event_id: event.id,
                                  user_id: user.id,
                                  points_awarded: event.award_points
    end
    attendance
  end


end