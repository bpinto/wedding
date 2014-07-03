class ProductsController < ApplicationController
  def index
    @products = Product.all.sort
  end
end
