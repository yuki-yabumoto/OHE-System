##
## File Name    : clothe.rb
## Version      : v1.0
## Designer     : 籔本悠紀
## Date         : 2021.06.06
## Purpose      : Clotheモデルの定義
##

class Clothe < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :user, class_name: "User", foreign_key: "user_id"

  mount_uploader :image, ImageUploader
end
