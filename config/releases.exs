import Config

config :ui, Ui.Endpoint,
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE")
