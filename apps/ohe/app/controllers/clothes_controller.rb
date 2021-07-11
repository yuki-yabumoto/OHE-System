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

    if params['tag_id'] && !params['tag_id'].empty?
      clothe_ids = []
      TagMap.where(user_id: user.id, tag_id: params['tag_id']).each do | tag_map |
        clothe_ids.push(tag_map.clothe_id)
      end
      param['id'] = clothe_ids
      @clothes = Clothe.where(param)
    end
    @clothes = Clothe.where(param)

    @clothes = @clothes.page(params[:page])

    # 画面に表示するタグのリストを作成
    @tag_list = [["選択してください", nil]]
    if user_tag_maps = TagMap.where(user_id: user.id)
      tag_ids = []
      user_tag_maps.each do | tag_map |
        tag_ids.push(tag_map.tag_id)
      end
      user_tags = Tag.order('name').where(id: tag_ids)
      user_tags.each do |tag|
        @tag_list.push([ tag.name, tag.id ])
      end
    end

    render action: "index"
  end

  def new
    @clothe = Clothe.new
  end

  def create
    user = current_user
    param = {}
    if params[:clothe].nil?
      param['kind'] = params['kind']
      param['color'] = params['color']
      param['type'] = params['type']
      tag_name = params['tag']
    else
      param = params[:clothe]
      tag_name = param[:tag]
      param.delete(:tag)
    end
    param['user_id'] = user.id

    if 10 < tag_name.length
      flash.alert = "タグは10文字以内にしてください"
      render action: "new"
    else
      @clothe = Clothe.new(param)
      if @clothe.save
        if tag_name
          if !tag= Tag.find_by(name: tag_name)
            tag = Tag.new(name: tag_name)
            tag.save
          end
          tag_map = TagMap.new(user_id: user.id, clothe_id: @clothe.id, tag_id: tag.id)
          tag_map.save
        end
        flash.notice = "服を追加しました"
        redirect_to :clothes
      else
        flash.alert = "服の追加に失敗しました"
        render action: "new"
      end
    end
  end

  def show
    clothe = Clothe.find(params[:id])
    redirect_to [ :edit, clothe ]
  end

  def edit
    @clothe = Clothe.find(params[:id]);
  end

  private def destroy_tag(clothe_id)
    tag_map = TagMap.find_by(clothe_id: clothe_id)
    tag_id = tag_map.tag_id
    tag_map.destroy!
    if !TagMap.find_by(tag_id: tag_id)
      Tag.find(tag_id).destroy
    end
  end

  def update
    @clothe = Clothe.find(params[:id])

    param = params[:clothe]
    tag_name = param[:tag]
    param.delete(:tag)
    if 10 < tag_name.length
      flash.alert = "タグは10文字以内にしてください"
      render action: "edit"
    else
      @clothe.assign_attributes(params[:clothe])
      if @clothe.save
        if !tag_name.empty? && tag_name != Tag.find(TagMap.find_by(clothe_id: params[:id]).tag_id)
          destroy_tag(params[:id])
          user = current_user
          if tag = Tag.find_by(name: tag_name)
            tag_map = TagMap.new(user_id: user.id, clothe_id: params[:id], tag_id: tag.id)
            tag_map.save
          else
            tag = Tag.new(name: tag_name)
            tag.save
            tag_map = TagMap.new(user_id: user.id, clothe_id: params[:id], tag_id: tag.id)
            tag_map.save
          end
        end
        flash.notice = "服情報を更新しました"
        redirect_to "/clothes?"
      else
        flash.alert = "服情報の更新に失敗しました"
        render action: "edit"
      end
    end
  end

 def destroy
    clothe = Clothe.find(params[:id])
    clothe.destroy!
    destroy_tag(params[:id])
    flash.notice = "服を削除しました"
    redirect_to :clothes
  end
end
