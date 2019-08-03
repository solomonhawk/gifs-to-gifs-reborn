use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ui, Ui.Endpoint,
  http: [port: 4002],
  server: false