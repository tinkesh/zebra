require 'test_helper'

class CareersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:careers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create career" do
    assert_difference('Career.count') do
      post :create, :career => { }
    end

    assert_redirected_to career_path(assigns(:career))
  end

  test "should show career" do
    get :show, :id => careers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => careers(:one).to_param
    assert_response :success
  end

  test "should update career" do
    put :update, :id => careers(:one).to_param, :career => { }
    assert_redirected_to career_path(assigns(:career))
  end

  test "should destroy career" do
    assert_difference('Career.count', -1) do
      delete :destroy, :id => careers(:one).to_param
    end

    assert_redirected_to careers_path
  end
end
