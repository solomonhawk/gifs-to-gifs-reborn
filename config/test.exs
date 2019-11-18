use Mix.Config

config :game, :children, []

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ui, GifMe.Ui.Endpoint,
  http: [port: 4002],
  server: false

config :junit_formatter,
  report_dir: "tmp/test-results/exunit",
  print_report_file: true,
  prepend_project_name?: true

config :bcrypt_elixir, :log_rounds, 4

config :db, GifMe.DB.Repo,
  database: "gifme_test",
  username: System.get_env("DB_USER") || "postgres",
  password: System.get_env("DB_PASS"),
  ownership_timeout: 30_000,
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: :erlang.system_info(:schedulers_online),
  pool_overflow: :erlang.system_info(:schedulers_online)

# database: "gifme_test",
# username: "solomonhawk",
# password: "",
# hostname: "localhost",
# port: "5432",
# pool: Ecto.Adapters.SQL.Sandbox,
# poolsize: 10
