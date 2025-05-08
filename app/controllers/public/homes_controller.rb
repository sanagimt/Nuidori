class Public::HomesController < ApplicationController

  def top
    if user_signed_in?
      redirect_to mypage_path
    end
  end

end
