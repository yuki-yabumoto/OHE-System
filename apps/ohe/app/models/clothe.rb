##
## File Name    : clothe.rb
## Version      : v1.1
## Designer     : 籔本悠紀 鶴田
## Date         : 2021.06.26
## Purpose      : Clotheモデルの定義
##

class Clothe < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :user, class_name: "User", foreign_key: "user_id"

  mount_uploader :image, ImageUploader

  def edit
    @clothe = Clothes.find(params[:id])
  end
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
#
