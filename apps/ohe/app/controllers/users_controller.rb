##
## File Name    : users_controller.rb
## Version      : 1.1
## Designer     : 籔本悠紀,中森楓太,田中航生
## Date         : 2021.0704
## Purpose      : Userのコントローラー
##

class UsersController < Base
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    #パスワード暗号化
    @user.hashed_password = params[:user][:password]
    if @user.save
      flash.notice = "アカウントを作成しました"
      redirect_to :login
    else
      flash.alert = "このメールアドレスは既に登録されています"
      render action: "new"
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash.notice = "ユーザーの情報を登録しました"
      redirect_to :index
    else
      flash.alert = "入力されていない項目があります"
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
