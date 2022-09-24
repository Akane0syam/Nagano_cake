class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end
  
  def index
  end
  
  def show
  end
  
  def create
    @cart_items = current_customer.cart_items.all
    # ログインユーザーのカートアイテムをすべて取り出して cart_items に入れる
    @order = current_customer.orders.new(order_params)
    if @order.save
      @cart_items.each do |cart|
        @order_item = OrderItem.new
        @order_item.item_id = cart.item_id
        @order_item.order_id = @order.id
        @order_item.order_quantity = cart.quantity
        @order_item.order_price = cart.item.price
        @order_item.save
      end
      redirect_to complete_public_orders_path
      cart_items.destroy_all #カートアイテムを全部削除する
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_number] == "1"# 1（自宅）
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name+current_customer.first_name
      
    elsif params[:order][:address_number] == "2"# 2（配送先一覧）
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      @order.address = Address.find(params[:order][:address_id]).address
      @order.name = Address.find(params[:order][:address_id]).name
      
    else params[:order][:address_number] == "3"# 3 (新配送先)
      
    end
  end

  def complete
  end
  
  private
  def order_params
    params.require(:order).permit(:customer_id,:postal_code,:address,:name,:shipping_cost,:total_payment,
    :payment_method,:status)
  end
  
  def address_params
    params.require(:address).permit(:customer_id,:name,:postal_code,:address)
  end
end
