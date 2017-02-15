require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "should not save event without any value" do
    event = Event.new
    assert_not event.save, "Saved the event without any value"
  end

  test "should not save event with duped code" do
    first = Event.create name: "First", code: "FIRST"
    first_again = Event.new name: first.name, code: first.code
    assert_not first_again.save, "Saved the event with a duped event code"
  end
end
