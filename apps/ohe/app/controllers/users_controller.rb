##
## File Name    : users_controller.rb
## Version      : 1.0
## Designer     : 籔本悠紀
## Date         : 2021.06.06
## Purpose      : Userのコントローラー
##

class UsersController < Base
  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end
end
