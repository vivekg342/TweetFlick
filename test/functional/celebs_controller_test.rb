require 'test_helper'

class CelebsControllerTest < ActionController::TestCase
  setup do
    @celeb = celebs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:celebs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create celeb" do
    assert_difference('Celeb.count') do
      post :create, celeb: @celeb.attributes
    end

    assert_redirected_to celeb_path(assigns(:celeb))
  end

  test "should show celeb" do
    get :show, id: @celeb.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @celeb.to_param
    assert_response :success
  end

  test "should update celeb" do
    put :update, id: @celeb.to_param, celeb: @celeb.attributes
    assert_redirected_to celeb_path(assigns(:celeb))
  end

  test "should destroy celeb" do
    assert_difference('Celeb.count', -1) do
      delete :destroy, id: @celeb.to_param
    end

    assert_redirected_to celebs_path
  end
end
