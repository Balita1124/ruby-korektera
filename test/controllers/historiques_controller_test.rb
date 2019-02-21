require 'test_helper'

class HistoriquesControllerTest < ActionController::TestCase
  setup do
    @historique = historiques(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:historiques)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create historique" do
    assert_difference('Historique.count') do
      post :create, historique: { action: @historique.action }
    end

    assert_redirected_to historique_path(assigns(:historique))
  end

  test "should show historique" do
    get :show, id: @historique
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @historique
    assert_response :success
  end

  test "should update historique" do
    patch :update, id: @historique, historique: { action: @historique.action }
    assert_redirected_to historique_path(assigns(:historique))
  end

  test "should destroy historique" do
    assert_difference('Historique.count', -1) do
      delete :destroy, id: @historique
    end

    assert_redirected_to historiques_path
  end
end
