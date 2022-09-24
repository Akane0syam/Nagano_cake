class Public::AddressesController < ApplicationController
  def index
    @addresses = current_customer.addresses
  end

  def edit
  end
  
  def create
  end
  
  def update
  end
  
  def destroy
  end
end
