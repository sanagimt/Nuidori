class ApplicationController < ActionController::Base

  def authenticate_admin!
    unless admin_signed_in?
      redirect_to root_path, alert: '指定したURLのアクセス権限がありません。'
    end
  end

end
