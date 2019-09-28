import Config

config :ui, Ui.Endpoint,
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE"),
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  server: true
