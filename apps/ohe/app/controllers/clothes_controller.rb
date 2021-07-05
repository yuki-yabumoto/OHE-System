##
## File Name    : clothes_controller.rb
## Version      : v3.0
## Designer     : 籔本悠紀
## Date         : 2021.07.03
## Purpose      : Clotheのコントローラー
##

class ClothesController < Base
  def index
    user = current_user
    param = {}
    param['user_id'] = user.id
    if params['kind'] || params['color'] || params['type']
      %w[kind color type].each do |key|
        if !params[key].empty?
          param[key] = params[key]
        end
      end
    end
    @clothes = Clothe.where(param)
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

    tag_name = param[:tag]
    param.delete(:tag)

    @clothe = Clothe.new(param)
    if @clothe.save
      @tag = Tag.new(clothe_id: @clothe.id, tag_name: tag_name)
      @tag.save
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
    if tag = Tag.find_by(clothe_id: params[:id])
      tag.destroy!
    end
    flash.notice = "服を削除しました"
    redirect_to :clothes
  end
end
