##
## File Name    : user.rb
## Version      : v1.1
## Designer     : 籔本悠紀,中森楓太,田中航生
## Date         : 2021.06.15
## Purpose      : Userモデルの定義,validatesの追加
##

class User < ApplicationRecord
  has_many :clothes, class_name: "Clothe", dependent: :destroy

  def hashed_password=(raw_password)
    if raw_password.kind_of?(String)
      self.password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.password = nil
    end
  end

  VALID_EMAIL_REGEX = /\A[\w+-.]+@[a-z\d-]+(.[a-z\d-]+)*.[a-z]+\z/i
  validates :email, uniqueness: true
  validates_format_of :email, with: VALID_EMAIL_REGEX
  validates :email, presence: true, on: :create
  validates :password, presence: true, on: :create
  validates :gender, presence: true, on: :update
  validates :place, presence: true, on: :update
  validates :from_time, presence: true, on: :update
  validates :to_time, presence: true, on: :update
  validates :favorite_color, presence: true, on: :update
  validates :favorite_type, presence: true, on: :update
end
