class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # ログイン後の遷移先
  def after_sign_in_path_for(resource)
    home_index_path
  end
  
  # ログアウト後の遷移先
  def after_sign_out_path_for(resource)
    home_index_path
  end
end
