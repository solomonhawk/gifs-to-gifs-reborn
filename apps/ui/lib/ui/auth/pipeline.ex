defmodule GifMe.Ui.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :ui,
    error_handler: GifMe.Ui.AuthErrorHandler,
    module: GifMe.Auth.Guardian

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.LoadResource, allow_blank: true
end
