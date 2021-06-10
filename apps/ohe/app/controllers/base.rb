##
## File Name    : base.rb
## Version      : v1.0
## Designer     : 籔本悠紀
## Date         : 2021.06.06
## Purpose      : 全てのコントローラーの基底クラス
##

class Base < ApplicationController
  private def current_user
    if session[:user_id]
      @current_user ||=
        User.find_by(id: session[:user_id])
    end
  end

  helper_method :current_user
end
