##
## File Name      : application_controller.rb
## Version        : v1.0
## Designer       : 籔本悠紀
## Date           : 2021.07.05
## Purpose        : エラー処理用コントローラー
##

class ErrorsController < Base
  def not_found
    render status: 404
  end

  def unprocessable_entity
    render status: 422
  end

  def internal_server_error
    render status: 500
  end
end
