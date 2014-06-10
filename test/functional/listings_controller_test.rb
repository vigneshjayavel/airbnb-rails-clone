require 'test_helper'

class ListingsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:listings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create listing" do
    assert_difference('Listing.count') do
      post :create, :listing => { }
    end

    assert_redirected_to listing_path(assigns(:listing))
  end

  test "should show listing" do
    get :show, :id => listings(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => listings(:one).to_param
    assert_response :success
  end

  test "should update listing" do
    put :update, :id => listings(:one).to_param, :listing => { }
    assert_redirected_to listing_path(assigns(:listing))
  end

  test "should destroy listing" do
    assert_difference('Listing.count', -1) do
      delete :destroy, :id => listings(:one).to_param
    end

    assert_redirected_to listings_path
  end
end
