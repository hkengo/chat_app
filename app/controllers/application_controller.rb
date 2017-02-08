class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_id_to_cookies
  
  # ------------- devise設定 ------------------  
  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    home_index_path
  end
  
  # ログアウト後の遷移先
  def after_sign_out_path_for(resource)
    home_index_path
  end
  
  def set_user_id_to_cookies
    cookies.signed[:user_id] ||= current_user.id if current_user
  end
  
  def configure_permitted_parameters
    # deviseのストロングパラメーター設定
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
