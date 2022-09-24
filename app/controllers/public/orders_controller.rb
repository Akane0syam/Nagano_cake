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
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.customer_address
      @order.name = current_customer.name
    elsif params[:order][:address_number] == "2"
     if Address.exists?(name: params[:order][:registered])# registered は viwe で定義しています
        @order.name = Address.find(params[:order][:registered]).name
        @order.address = Address.find(params[:order][:registered]).address
      else
        render :new
        # 既存のデータを使っていますのでありえないですが、万が一データが足りない場合は new を render します
      end
    else params[:order][:address_number] == "3"
      @address_new = current_customer.addresses.new(address_params)
    end
      
  end

  def complete
  end
  
  private
  def order_params
  end
  
  def address_params
  end
end
