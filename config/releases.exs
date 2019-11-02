import Config

config :ui, GifMe.Ui.Endpoint, secret_key_base: System.fetch_env!("SECRET_KEY_BASE")
