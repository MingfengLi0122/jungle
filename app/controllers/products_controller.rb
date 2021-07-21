class ProductsController < ApplicationController

  def index
    # uses MODEL
    @products = Product.all.order(created_at: :desc)
    # VIEW
    #render :index / behind the theme
  end

  def show
    #instance variable @prodect is automaticlly transfered between controller into the view
    @product = Product.find params[:id]
    #render :show implicit
  end

end
