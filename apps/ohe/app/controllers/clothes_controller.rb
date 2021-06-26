##
## File Name    : clothes_controller.rb
## Version      : v2.0
## Designer     : 籔本悠紀
## Date         : 2021.06.25
## Purpose      : Clotheのコントローラー
##

class ClothesController < Base
  def new
    @clothe = Clothe.new
  end

  def show
    user = User.find(params[:id])
    @clothes = Clothe.where(user_id: user.id)
    redirect_to :index
  end

  def edit
     @clothe = Clothe.find(params[:id]);
  end

  def create
    user = current_user
    param = params[:clothe]
    param['user_id'] = user.id
    @clothe = Clothe.new(param)
    if @clothe.save
      redirect_to :index
    else
      render action:"new"
    end
  end

  def destroy
    clothe = Clothe.find(params[:id])
    clothe.destroy!
    flash.notice = "服を削除しました"
    redirect_to :index
  end
end
