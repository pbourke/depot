require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = products(:one)
    @update = {
      :title => 'Foobar pirateship',
      :description => 'Born on a foobar pirateship',
      :image_url => '/pirates.jpg',
      :price => 14.37
    }
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, :product => @update
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should reject duplicate" do
    assert_no_difference('Product.count') do
      post :create, :product => products(:one)
    end
  end

  test "should show product" do
    get :show, :id => @product.to_param
    assert_response :success
  end

  test "should show Bacon" do
    bacon = products(:bacon)
    get :show, :id => bacon.id
    assert_select '#product_title', /Bacon/
  end

  test "should get edit" do
    get :edit, :id => @product.to_param
    assert_response :success
  end

  test "should update product" do
    put :update, :id => @product.to_param, :product => @update
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    p2 = products(:two)
    assert_difference('Product.count', -1) do
      delete :destroy, :id => p2.to_param
    end

    assert_redirected_to products_path
  end
end
