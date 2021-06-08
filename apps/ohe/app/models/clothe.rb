##
## File Name    : clothe.rb
## Version      : v1.0
## Designer     : 籔本悠紀
## Date         : 2021.06.06
## Purpose      : Clotheモデルの定義
##

class Clothe < ApplicationRecord
  mount_uploader :image, ImageUploader
end
