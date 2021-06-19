##
## File Name    : user.rb
## Version      : v1.1
## Designer     : 籔本悠紀,中森楓太
## Date         : 2021.06.15
## Purpose      : Userモデルの定義
##

class User < ApplicationRecord
  def hashed_password=(raw_password)
    if raw_password.kind_of?(String)
      self.password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.password = nil
    end
  end
end
