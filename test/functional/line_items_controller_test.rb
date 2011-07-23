require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, :product_id => products(:bacon).id
    end

    assert_redirected_to cart_path(assigns(:line_item).cart)
  end

  test "should show line_item" do
    get :show, :id => @line_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @line_item.to_param
    assert_response :success
  end

  test "should update line_item" do
    put :update, :id => @line_item.to_param, :line_item => @line_item.attributes
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, :id => @line_item.to_param
    end

    assert_redirected_to line_items_path
  end

  test "should add unique product" do
    cart = carts(:one)
    product = products(:one)
    session[:cart_id] = cart.id
    assert_difference('cart.line_items.count', 1) do
      post :create, :product_id => product.id
    end
  end

  test "should add duplicate product" do
    cart = carts(:one)
    product = products(:one)
    session[:cart_id] = cart.id
    post :create, :product_id => product.id
    assert_no_difference('cart.line_items.count') do
      post :create, :product_id => product.id
    end
    assert_equal 2, cart.line_items[0].quantity
  end
end
