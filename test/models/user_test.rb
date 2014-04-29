require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  should have_many(:user_friendships)
  
  should have_many(:friends)
  
  test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end

    test "a user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end
  
  test "a user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end
  
  test "a user should enter a unique profile name" do
    user = User.new
    user.profile_name = users(:roberto).profile_name
    assert !user.save
    #puts user.errors.inspect
    assert !user.errors[:profile_name].empty?
  end   
  
  test "a user should have a profile name without spaces" do
    user = User.new(first_name: 'Robertos', last_name: 'Alicatas', email: 'robertos.alicatas@example.com')
    user.password = user.password_confirmation = 'asdfasdf'
    user.profile_name = "My profile name"
    assert !user.save
    assert !user.errors[:profile_name].empty?
    assert user.errors[:profile_name].include?("Must be formatted correctly.")
  end
  
  test "a user can have a correctly formatted profile name" do
    user = User.new(first_name: 'Robertos', last_name: 'Alicatas', email: 'robertos.alicatas@example.com')
    user.password = user.password_confirmation = 'asdfasdf'
    user.profile_name = 'beos_1'
    assert user.valid? 
  end
  
  test "that no error is rised when trying to access a friend list" do
    assert_nothing_raised do
      users(:roberto).friends
    end
  end
  
  test "that creating friendships on a user works" do
    users(:roberto).friends << users(:jim)
    users(:roberto).friends.reload
    assert users(:roberto).friends.include?(users(:jim))
  end
  
end
