class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @addresses = current_customer.addresses
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def show
    
  end
  
  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.shipping_cost = 800
    
    
    if params[:order][:address_number] == "1"# 1（自宅）
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name+current_customer.first_name
      
    elsif params[:order][:address_number] == "2"# 2（配送先一覧）
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      @order.address = Address.find(params[:order][:address_id]).address
      @order.name = Address.find(params[:order][:address_id]).name
      
    else params[:order][:address_number] == "3"# 3 (新配送先)
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
  end

    def create
    @cart_items = current_customer.cart_items.all
    # ログインユーザーのカートアイテムをすべて取り出して cart_items に入れる
    @order = current_customer.orders.new(order_params)
    if @order.save
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.order_id = @order.id
        @order_detail.amount = cart_item.amount
        @order_detail.price = cart_item.item.price
        @order_detail.save
      end
      @cart_items.destroy_all #カートアイテムを全部削除する
      redirect_to complete_public_orders_path
    else
      @order = Order.new(order_params)
      render :new
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
