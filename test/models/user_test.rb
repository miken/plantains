require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save user without any value" do
    user = User.new
    assert_not user.save, "Saved the user without any value"
  end
end
