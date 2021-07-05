##
## File Name      : exceptions_app.rb
## Version        : v1.0
## Designer       : 籔本悠紀
## Date           : 2021.06.28
## Purpose        : 例外処理用のconfig
##

Rails.application.configure do
  config.exceptions_app = ->(env) do
    request = ActionDispatch::Request.new(env)

    action =
      case request.path_info
        when "/404"; :not_found
        when "/422"; :unprocessable_entity
        else; :internal_server_error
      end

    ErrorsController.action(action).call(env)
  end
end
