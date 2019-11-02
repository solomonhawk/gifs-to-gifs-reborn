defmodule GifMe.Ui.Presence do
  use Phoenix.Presence,
    otp_app: :ui,
    pubsub_server: GifMe.Ui.PubSub
end
