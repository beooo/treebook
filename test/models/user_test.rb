require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  should have_many(:user_friendships)
  
  should have_many(:friends)
  
  should have_many(:pending_user_friendships)
  should have_many(:pending_friends)

  should have_many(:requested_user_friendships)
  should have_many(:requested_friends)

  should have_many(:blocked_user_friendships)
  should have_many(:blocked_friends)

  should have_many(:accepted_user_friendships)
  should have_many(:accepted_friends)

  should have_many(:activities)


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
    assert users(:roberto).pending_friends.include?(users(:jim))
  end

  test "that calling to_param on a user returns the profile_name" do
    assert_equal "beo", users(:roberto).to_param
  end
  
  context "#has_blocked?" do
    should "return true if a user blocked another user" do
      assert users(:roberto).has_blocked?(users(:blocked_friend))
    end

    should "return false if a user not blocked another user" do
      assert !users(:roberto).has_blocked?(users(:jim))
    end
  end

  context "#create_activity" do
    should "increase the Activity count" do
      assert_difference "Activity.count" do
        users(:roberto).create_activity(statuses(:one), 'created')
      end
    end

    should "set the targetable instance to the item passed in" do
      activity = users(:roberto).create_activity(statuses(:one), 'created')
      assert_equal activity.targetable, statuses(:one)
    end

    should "increase the Activity count with an Album" do
      assert_difference "Activity.count" do
        users(:roberto).create_activity(albums(:vacation), 'created')
      end
    end

    should "set the targetable instance to the item passed in with an Album" do
      activity = users(:roberto).create_activity(albums(:vacation), 'created')
      assert_equal activity.targetable, albums(:vacation)
    end

  end

end
