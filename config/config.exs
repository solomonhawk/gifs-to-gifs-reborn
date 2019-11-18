import Config

config :ui,
  generators: [context_app: false, binary_id: true]

config :game, :children, [GifMe.Game.ServerSupervisor]

config :ui, GifMe.Ui.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jCsRK/76GSGzIgD58BfDKDpgATmSYt7BbYMgNenofwUEtjqEc4f0UoSX1EttU5E0",
  render_errors: [view: GifMe.Ui.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GifMe.Ui.PubSub, adapter: Phoenix.PubSub.PG2]

config :db, ecto_repos: [GifMe.DB.Repo]

config :auth, GifMe.Auth.Guardian,
  issuer: "GifMe",
  serializer: GifMe.Auth.Serializer,
  secret_key: "kP6FbBEQkKlY5gJU4bPcqtOGngIhlGPuMbkG9B96xJlzrCGBmpfLw54oUIaJ1dlF"

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

# environment specific config
import_config "#{Mix.env()}.exs"
