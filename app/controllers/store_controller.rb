class StoreController < ApplicationController
  def index
    session[:counter] ||= 0
    session[:counter] += 1
    @counter = session[:counter]
    @products = Product.all
    @cart = current_cart
  end

end
