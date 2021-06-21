##
## File Name    : user.rb
## Version      : v1.0
## Designer     : 籔本悠紀,田中航生
## Date         : 2021.06.06
## Purpose      : Userモデルの定義,validatesの追加
##

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+-.]+@[a-z\d-]+(.[a-z\d-]+)*.[a-z]+\z/i
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/
  validates :email, uniqueness: true
  validates_format_of :email, with: VALID_EMAIL_REGEX
  validates_format_of :password, with: VALID_PASSWORD_REGEX
  validates :email, presence: true, on: :create
  validates :password, presence: true, on: :create
  validates :gender, presence: true, on: :update
  validates :place, presence: true, on: :update
  validates :from_time, presence: true, on: :update
  validates :to_time, presence: true, on: :update
  validates :favorite_color, presence: true, on: :update
  validates :favorite_type, presence: true, on: :update
end
