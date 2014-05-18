require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase
  setup do
    @album = albums(:vacation)
    @user = users(:roberto)
    sign_in users(:roberto)
  end

  test "should get index" do
    get :index, profile_name: @user.profile_name
    assert_response :success
    assert_not_nil assigns(:albums)
  end

  test "should get new" do
    get :new, profile_name: @user.profile_name
    assert_response :success
  end

  test "should create album" do
    assert_difference('Album.count') do
      post :create, profile_name: @user.profile_name, album: { title: @album.title }
    end

    assert_redirected_to album_path(assigns(:album))
  end

  test "should create activity on create album" do
    assert_difference('Activity.count', 1) do
      post :create, profile_name: @user.profile_name, album: { title: @album.title }
    end
  end


  test "should show album" do
    get :show, profile_name: @user.profile_name, id: @album
    assert_response :redirect
    assert_redirected_to album_pictures_path(@album)
  end

  test "should get edit" do
    get :edit, profile_name: @user.profile_name, id: @album
    assert_response :success
  end

  test "should update album" do
    patch :update, profile_name: @user.profile_name,  id: @album, album: { title: @album.title }
    assert_redirected_to album_pictures_path(@user.profile_name, @album.id)
  end

  test "should create activity on update album" do
    assert_difference('Activity.count', 1) do
      patch :update, profile_name: @user.profile_name,  id: @album, album: { title: @album.title }
    end
  end

  test "should destroy album" do
    assert_difference('Album.count', -1) do
      delete :destroy, profile_name: @user.profile_name, id: @album.id
    end

    assert_redirected_to albums_path
  end

  test "should create activity on destroy album" do
    assert_difference('Activity.count', 1) do
      delete :destroy, profile_name: @user.profile_name, id: @album.id
    end
  end


end
