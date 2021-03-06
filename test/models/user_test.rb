require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    $user = users(:valid_one)
  end
  
  test "can register" do
	user = User.new(username: "UserX", email: "lol@finance.cloud", password: "admin2")
    assert user.save, "Error : fail saving valid user"
  end

  test "no username twice" do
	user = User.new(username: $user.username, email: "lol@finance.cloud", password: "admin2")
    assert_not user.save, "Error : success saving user with same username"
  end
  
  test "no email twice" do
	user = User.new(username: "userX", email: $user.email, password: "admin2")
    assert_not user.save, "Error : success saving user with same email"
  end
  
  test "username too short" do
    user = User.new(username: "Ad", email: "lol@finance.cloud", password: "admin2")
    assert_not user.save, "Error : sucess saving user, username too short"
  end
  
  test "username too long" do
    user = User.new(username: "1234567890123456", email: "lol@finance.cloud", password: "admin2")
    assert_not user.save, "Error : sucess saving user, username too long"
  end
  
  test "invalid email" do
    user = User.new(username: "Admin2", email: "lol@finance.", password: "admin2")
    assert_not user.save, "Error : sucess saving user, invalid email"
  end
  
  test "invalid rank" do
    user = User.new(username: "Admin3", email: "lol@finance.cloud", password: "admin2", rank: 1000)
    assert_not user.save, "Error : sucess saving user, invalid rank"
  end
  
  test "password too short" do
    user = User.new(username: "UserX", email: "lol@finance.cloud", password: "admin")
    assert_not user.save, "Error : sucess saving user, username too short"
  end
  
  test "password too long" do
    user = User.new(username: "UserX", email: "lol@finance.cloud", password: "123456789012345678901234567890123456789012345678901")
    assert_not user.save, "Error : sucess saving user, username too long"
  end
  
end
