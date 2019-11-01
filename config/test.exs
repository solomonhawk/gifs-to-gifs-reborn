use Mix.Config

config :game, :children, []

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ui, Ui.Endpoint,
  http: [port: 4002],
  server: false

config :junit_formatter,
  report_dir: Path.join(File.cwd!(), "_reports"),
  print_report_file: true,
  prepend_project_name?: true
