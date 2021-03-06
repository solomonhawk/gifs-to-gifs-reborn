import Config

config :ui,
  generators: [context_app: false]

config :game, :children, [GameApp.ServerSupervisor]

config :ui, Ui.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jCsRK/76GSGzIgD58BfDKDpgATmSYt7BbYMgNenofwUEtjqEc4f0UoSX1EttU5E0",
  render_errors: [view: Ui.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ui.PubSub, adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

# environment specific config
import_config "#{Mix.env()}.exs"
