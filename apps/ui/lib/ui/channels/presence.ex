defmodule Ui.Presence do
  use Phoenix.Presence,
    otp_app: :ui,
    pubsub_server: Ui.PubSub
end
