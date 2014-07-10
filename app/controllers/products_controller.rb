class ProductsController < ApplicationController
  def index
    @products = Product.all.sort
  end

  def show
    @product = Product.find params[:id]
  end
end
