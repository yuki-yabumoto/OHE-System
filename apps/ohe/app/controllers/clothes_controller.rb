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
    redirect_to [:show_clothes, user]
  end
  
  def edit
    @clothe = Clothe.find(params[:id]);
end

def destroy
    @clothe = Clothe.find(parms[:id]);
    @clothe.destroy;
end

end
