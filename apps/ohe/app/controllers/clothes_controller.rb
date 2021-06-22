##
## File Name    : clothes_controller.rb
## Version      : v1.0
## Designer     : 籔本悠紀
## Date         : 2021.06.06
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
    @clothe = Clothe.new(params[:clothe])
    if @clothe.save
      redirect_to :index
    else
      render action:"new"
    end

  end

end
