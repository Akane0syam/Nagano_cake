class Admin::OrdersController < ApplicationController
  def index
     @orders = current_customer.orders
  end
  
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
  
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    flash[:notice] = "注文ステータスの変更しました"
    redirect_to admin_order_path(@order)
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name,
    :shipping_cost, :total_payment, :payment_method, :order_id, :item_id, :price,
    :amount)
  end
end

