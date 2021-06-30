## File Name    : clothes_controller.rb
## Version      : v2.0
## Designer     : 籔本悠紀
## Date         : 2021.06.29
## Purpose      : Clotheのコントローラー
##

class ClothesController < Base
  def index
    user = current_user
    @clothes = Clothe.where(user_id: user.id)
    render action: "index"
  end

  def new
    @clothe = Clothe.new
  end

  def show
    clothe = Clothe.find(params[:id])
    redirect_to [ :edit, clothe ]
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
      flash.notice = "服を追加しました"
      redirect_to :clothes
    else
      flash.alert = "服の追加に失敗しました"
      render action:"new"
    end
  end

  def destroy
    clothe = Clothe.find(params[:id])
    clothe.destroy!
    flash.notice = "服を削除しました"
    redirect_to :clothes
  end
end
