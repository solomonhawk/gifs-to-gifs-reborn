if System.get_env("CI") == "true" do
  "tmp/test-results/exunit"
  |> Path.relative()
  |> File.mkdir_p!()

  ExUnit.configure(formatters: [JUnitFormatter, ExUnit.CLIFormatter])
end

ExUnit.start(trace: System.get_env("MIX_TEST_VERBOSE") == "true")

Ecto.Adapters.SQL.Sandbox.mode(GifMe.DB.Repo, :manual)
