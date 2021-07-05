##
## File Name      : application_controller.rb
## Version        : v1.0
## Designer       : 籔本悠紀
## Date           : 2021.07.05
## Purpose        : アプリケーション全体のコントローラー
##

class ApplicationController < ActionController::Base

  class Forbidden < ActionController::ActionControllerError
  end

  class IpAddressRejected < ActionController::ActionControllerError
  end

  include ErrorHandlers if Rails.env.production?
end
