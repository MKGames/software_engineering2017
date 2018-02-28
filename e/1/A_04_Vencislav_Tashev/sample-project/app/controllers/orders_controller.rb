class OrdersController < ApplicationController
  before_action :set_product
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = @product.orders.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def create
    @order = @product.orders.new order_params

    if @order.save
      redirect_to [@product, @order]
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @order.update_attributes order_params
      redirect_to [@product, @order]
    else
      render 'edit'
    end
  end

  def destroy
    @order.destroy
    redirect_to orders_path
  end

  private

  def order_params
    params.require(:order).permit(:ordered_at)
  end

  def set_product
    @product = Product.find_by id: params[:product_id]
  end

  def set_order
    @order = @product.orders.find_by id: params[:id]
  end
end
