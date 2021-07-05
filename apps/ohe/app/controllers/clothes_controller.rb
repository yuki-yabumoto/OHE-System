##
## File Name    : clothes_controller.rb
## Version      : v3.0
## Designer     : 籔本悠紀
## Date         : 2021.07.05
## Purpose      : Clotheのコントローラー
##

class ClothesController < Base
  def index
    user = current_user
    param = {}
    param['user_id'] = user.id

    # 絞込み条件を抽出
    if params['kind'] && !params['kind'].empty? then param['kind'] = params['kind'] end
    if params['color'] && !params['color'].empty? then param['color'] = params['color'] end
    if params['type'] && !params['type'].empty? then param['type'] = params['type'] end
    if params['tag_id'] && !params['tag_id'].empty? then param['id'] = TagMap.where(tag_id: params['tag_id']) end

    @clothes = Clothe.where(param)

    # 画面に表示するタグのリストを作成
    @tag_list = [["選択してください", nil]]
    Tag.all.order('name').each do |tag|
      @tag_list.push([ tag.name, tag.id ])
    end
    render action: "index"
  end

  def new
    @clothe = Clothe.new
  end

  def create
    user = current_user
    param = params[:clothe]
    param['user_id'] = user.id

    tag_name = param[:tag]
    param.delete(:tag)

    @clothe = Clothe.new(param)
    if @clothe.save
      if tag_name
        if !tag= Tag.find_by(name: tag_name)
          tag = Tag.new(name: tag_name)
          tag.save
        end
        tag_map = TagMap.new(clothe_id: @clothe.id, tag_id: tag.id)
        tag_map.save
      end
      flash.notice = "服を追加しました"
      redirect_to :clothes
    else
      flash.alert = "服の追加に失敗しました"
      render action:"new"
    end
  end

  def show
    clothe = Clothe.find(params[:id])
    redirect_to [ :edit, clothe ]
  end

  def edit
    @clothe = Clothe.find(params[:id]);
  end

 def destroy
    clothe = Clothe.find(params[:id])
    clothe.destroy!
    if tag_map = TagMap.find_by(clothe_id: params[:id])
      tag_id = tag_map.tag_id
      tag_map.destroy!
      if !TagMap.find_by(id: tag_id)
        Tag.find(tag_id).destroy
      end
    end
    flash.notice = "服を削除しました"
    redirect_to :clothes
  end
end
