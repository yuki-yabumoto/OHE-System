##
## File Name    : clothes_controller.rb
## Version      : v2.0
## Designer     : 籔本悠紀
## Date         : 2021.06.25
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
    # user = current_user
    logger.debug("Clothe params: #{params}")
    # @clothes = Clothe.find(params[:id])
    # render action: "show"
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
      redirect_to :clothes
    else
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
