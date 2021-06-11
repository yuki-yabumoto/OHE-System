##
## File Name    : login_form.rb
## Version      : 1.0
## Designer     : 籔本悠紀
## Date         : 2021.06.05
## Purpose      : ログインフォームのクラス
##

class LoginForm
  include ActiveModel::Model

  attr_accessor :email, :password
end
