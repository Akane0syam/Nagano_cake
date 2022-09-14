class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to public_customer_path
    else
      render :edit
    end
  end
  
  def quit
  end
  
  def out #退会のアクション
    @customer = current_customer
    @customer.update(is_deleted: true)#is_deletedカラムの値をtrueに更新
    reset_session #現在のログイン状況をリセットする
    flash[:notice] = "退会が完了しました。"
    redirect_to root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_kana,
    :first_name_kana, :postal_code, :address, :telephone_number, :is_deleted)
  end
end
