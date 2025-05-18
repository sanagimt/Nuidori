class Public::HomesController < ApplicationController

  def top
    if user_signed_in?
      redirect_to mypage_path
    elsif admin_signed_in?
      redirect_to admin_root_path
    end
  end

end
