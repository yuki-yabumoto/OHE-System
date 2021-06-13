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
      clothe = Clothe.find(params[:id])
      redirect_to [ :edit, :user, clothe ]
    end
    
    def edit
      @clothe = Clothe.find(params[:id]);
    end
  
    def destroy
      clothe = Clothe.find(parms[:id]);
      clothe.destroy!;
      redirect_to :clothes_show;
    end
end
  
