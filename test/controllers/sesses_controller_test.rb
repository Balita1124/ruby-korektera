require 'test_helper'

class SessesControllerTest < ActionController::TestCase
  setup do
    @sess = sesses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sesses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sess" do
    assert_difference('Sess.count') do
      post :create, sess: {  }
    end

    assert_redirected_to sess_path(assigns(:sess))
  end

  test "should show sess" do
    get :show, id: @sess
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sess
    assert_response :success
  end

  test "should update sess" do
    patch :update, id: @sess, sess: {  }
    assert_redirected_to sess_path(assigns(:sess))
  end

  test "should destroy sess" do
    assert_difference('Sess.count', -1) do
      delete :destroy, id: @sess
    end

    assert_redirected_to sesses_path
  end
end
