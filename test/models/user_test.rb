require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @created = User.create name: "One", email: "my@email.com", phone: "310 311 3123"
  end

  test "should not save user without any value" do
    user = User.new
    assert_not user.save, "Saved the user without any value"
  end

  # Unique email or phone number
  test "should not save user with duped email" do
    duped = User.new name: "Duped", email: "my@email.com"
    assert_not duped.save, "Saved the user with a duped email address"
  end

  test "should not save user with duped phone number" do
    duped = User.new name: "Duped", phone: "+1 310 311 3123"
    assert_not duped.save, "Saved the user with a duped phone number"
  end

  # Email validations

  # Phone number validations

  test "should not save without valid phone format" do
    user = User.new phone: "blah"
    assert_not user.save, "Saved the user with an invalid phone format"
  end

  test "should not save without valid US phone number" do
    user = User.new phone: "844 123456789"
    assert_not user.save, "Saved the user with an invalid US phone number"
  end

  test "should not save with fake US phone number" do
    user = User.new phone: "123 456 7890"
    assert_not user.save, "Saved the user with a fake US phone number"
  end  

  test "should save with valid US phone number 1" do
    user = User.new phone: "818 456 7890"
    assert user.save, "Did not save the user with valid US phone number"
  end

  test "should save with valid US phone number 2" do
    user = User.new phone: "+1 818 456 7890"
    assert user.save, "Did not save the user with valid US phone number"
  end

  test "should save with valid US phone number 3" do
    user = User.new phone: "(818) 456-7890"
    assert user.save, "Did not save the user with valid US phone number"
  end
end
