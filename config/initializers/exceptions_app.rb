Rails.application.configure do
  config.execptions_app = -> (env) do
    request = ActionDispatch::Request.new(env)

    action =
      case request.path_info
      when "/404"; :not_found
      else; :internal_server_error
      end
    ErrorsController.action(action).call(env)
  end
end
