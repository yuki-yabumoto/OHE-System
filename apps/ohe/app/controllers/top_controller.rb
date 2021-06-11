##
## File Name    : top_controller.rb
## Version      : v1.0
## Designer     : 籔本悠紀
## Date         : 2021.06.06
## Purpose      : Topコントローラー
##

class TopController < Base
  def index
    render action: "index"
  end
end
