##
## File Name    : user.rb
## Version      : v1.0
## Designer     : 籔本悠紀
## Date         : 2021.06.06
## Purpose      : Userモデルの定義
##

class User < ApplicationRecord
  has_many :clothes, class_name: "Clothe", dependent: :destroy
end
