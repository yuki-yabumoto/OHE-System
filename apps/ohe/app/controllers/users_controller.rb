##
## File Name    : users_controller.rb
## Version      : 1.0
## Designer     : 籔本悠紀,中森楓太
## Date         : 2021.06.21
## Purpose      : Userのコントローラー
##

class UsersController < Base
  def new
    @user = User.new
  end
  def create
    @user=User.new(params[:user])
    ##パスワード暗号化
    @user.hashed_password = params[:user][:password]
    if @user.save
      redirect_to :login
    else
      render action:"new"
    end
  end
  def edit
    @user=current_user
  end
  def update
    @user=current_user
    if @user.update(user_params)
      redirect_to :index
    else
      render action:"edit"
    end
  end
  private def user_params
    params.require(:user).permit(
      :gender, :place, :datetime,
      :from_time, :to_time, :favorite_color,
      :favorite_type
      )
  end

end
