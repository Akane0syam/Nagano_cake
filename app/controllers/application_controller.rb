class ApplicationController < ActionController::Base
  before_action :authenticate_customer!, except: [:about]
  
  def after_sign_in_path_for(resource)
    public_customer_path(@customer.id) # ログイン後に遷移するpathを設定
  end
  
  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end
end
