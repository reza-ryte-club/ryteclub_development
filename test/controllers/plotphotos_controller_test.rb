require 'test_helper'

class PlotphotosControllerTest < ActionController::TestCase
  setup do
    @plotphoto = plotphotos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:plotphotos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create plotphoto" do
    assert_difference('Plotphoto.count') do
      post :create, plotphoto: { image: @plotphoto.image, plot_id: @plotphoto.plot_id }
    end

    assert_redirected_to plotphoto_path(assigns(:plotphoto))
  end

  test "should show plotphoto" do
    get :show, id: @plotphoto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @plotphoto
    assert_response :success
  end

  test "should update plotphoto" do
    patch :update, id: @plotphoto, plotphoto: { image: @plotphoto.image, plot_id: @plotphoto.plot_id }
    assert_redirected_to plotphoto_path(assigns(:plotphoto))
  end

  test "should destroy plotphoto" do
    assert_difference('Plotphoto.count', -1) do
      delete :destroy, id: @plotphoto
    end

    assert_redirected_to plotphotos_path
  end
end
