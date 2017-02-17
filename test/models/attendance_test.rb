require 'test_helper'

class AttendanceTest < ActiveSupport::TestCase
  def setup
    @user = users(:existing)
    @event = events(:one)
    @attendance = Attendance.create event: @event, user: @user, points_awarded: 100
  end

  test "should have one attendance record initially" do
    assert_equal 1, @event.users.count
  end

  test "should not create multiple attendance records" do
    dupe = Attendance.create event: @event, user: @user, points_awarded: 200
    assert_equal 1, @event.users.where(id: @user.id).count,
                    "Saved user's attendance that already exists"
  end

  test "locate_code_and_phone should not create multiple attendance records" do
    dupe = Attendance.locate_code_and_phone user_phone: @user.phone, event_code: @event.code
    assert_equal 1, @event.users.where(id: @user.id).count,
                    "Saved user's attendance that already exists"
  end

  test "locate_code_and_phone creates new user for unknown number" do
    dupe = Attendance.locate_code_and_phone user_phone: "888 888 8888", event_code: @event.code
    new_user = User.find_by_phone "+18888888888"
    assert_not_nil new_user
    assert_equal "Unknown", new_user.name
  end

  test "should not check in a nonexistent event" do
    attendance = Attendance.locate_code_and_phone user_phone: @user.phone, event_code: "NOTHERE"
    assert_not attendance.save, "Saved a checkin to a nonexistent event"
  end  
end
