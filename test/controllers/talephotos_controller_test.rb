require 'test_helper'

class TalephotosControllerTest < ActionController::TestCase
  setup do
    @talephoto = talephotos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:talephotos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create talephoto" do
    assert_difference('Talephoto.count') do
      post :create, talephoto: { cover: @talephoto.cover, tale_id: @talephoto.tale_id }
    end

    assert_redirected_to talephoto_path(assigns(:talephoto))
  end

  test "should show talephoto" do
    get :show, id: @talephoto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @talephoto
    assert_response :success
  end

  test "should update talephoto" do
    patch :update, id: @talephoto, talephoto: { cover: @talephoto.cover, tale_id: @talephoto.tale_id }
    assert_redirected_to talephoto_path(assigns(:talephoto))
  end

  test "should destroy talephoto" do
    assert_difference('Talephoto.count', -1) do
      delete :destroy, id: @talephoto
    end

    assert_redirected_to talephotos_path
  end
end
