class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_owner_product, only: %i[ edit update destroy ]

  def index
    @owner = params[:owner] || 'all'
    @products  = current_user.products if @owner == 'myself'
    @products  = Product.all if @owner == 'all'
  end

  def new
    @product = Product.new
  end

  def create
    @product = current_user.products.new(product_params)

    return redirect_to @product if @product.save

    redner :new
  end

  def show
    @product = Product.find(params[:id])
    if current_user.products.include?(Product.find(params[:id]))
      @chats = @product.chats
    end
  end

  def edit
  end

  def update
    return redirect_to products_path if @product.update(product_params)

    render :edit
  end

  def destroy
    @product.destroy

    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :available)
  end

  def find_owner_product
    @product = current_user.products.find(params[:id])
  end
end