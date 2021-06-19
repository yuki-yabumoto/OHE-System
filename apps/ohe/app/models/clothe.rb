##
## File Name    : clothe.rb
## Version      : v1.0
## Designer     : 籔本悠紀 鶴田
## Date         : 2021.06.06
## Purpose      : Clotheモデルの定義
##

class Clothe < ApplicationRecord
  mount_uploader :image, ImageUploader

  def edit
    @clothes = clothes.find()
  end

#   def create
#     kind = params[:kind]
#     if @clothes.save
#       flash.notice = ""
#       redirect_to  :ademim
#     else
#       render action:  "new"
#     end
#   end
#
#   def create
#
#
# end
#
# clothes: {
#   clothes_type =
#   clothes_color =
#   clothes_geer =
#   clothes_picture =
#
# }
