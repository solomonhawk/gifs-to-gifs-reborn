ExUnit.configure(formatters: [JUnitFormatter, ExUnit.CLIFormatter])
ExUnit.start(trace: System.get_env("MIX_TEST_VERBOSE") == "true")
