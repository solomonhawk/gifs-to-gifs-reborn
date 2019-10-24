defmodule GifMe.MixProject do
  use Mix.Project

  def project do
    [
      apps_path: "apps",
      version: File.read!("VERSION") |> String.trim(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      dialyzer: dialyzer(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      docs: [
        main: "readme",
        extras: ["README.md"],
        output: "docs"
      ],
      releases: [
        gifme: [
          include_executables_for: [:unix],
          applications: [ui: :permanent, game: :permanent],
          steps: [:assemble, &make_tar/1]
        ]
      ]
    ]
  end

  # Dependencies listed here are available only for this
  # project and cannot be accessed from applications inside
  # the apps folder.
  #
  # Run "mix help deps" for examples and options.
  defp deps do
    [
      {:excoveralls, "~> 0.10", only: [:dev, :test]},
      {:junit_formatter, "~> 3.0", only: [:dev, :test]},
      {:mix_test_watch, "~> 0.8", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.19", only: [:dev, :test]},
      {:earmark, "~> 1.2", only: [:dev, :test]},
      {:cortex, "~> 0.1", only: [:dev, :test]}
    ]
  end

  defp aliases do
    [
      coveralls: ["coveralls --umbrella"],
      "coveralls.html": ["coveralls.html --umbrella"],
      "coveralls.detail": ["coveralls.detail --umbrella"]
    ]
  end

  defp dialyzer do
    [
      flags: [:error_handling, :race_conditions, :underspecs, :unmatched_returns],
      plt_add_apps: [:ex_unit, :mix],
      plt_file: {:no_warn, "_plts/dialyzer.plt"},
      ignore_warnings: ".dialyzer_ignore.exs"
    ]
  end

  defp make_tar(%Mix.Release{} = rel) do
    tar_filename = "#{rel.name}.tar.gz"
    out_path = Path.join(rel.path, tar_filename)

    dirs =
      ["bin", "lib", Path.join("releases", rel.version), "erts-#{rel.erts_version}"] ++
        [Path.join("releases", "COOKIE"), Path.join("releases", "start_erl.data")]

    files = Enum.map(dirs, &{String.to_charlist(&1), String.to_charlist(Path.join(rel.path, &1))})
    :ok = :erl_tar.create(String.to_charlist(out_path), files, [:dereference, :compressed])
    :ok = File.rename(out_path, Path.join(rel.version_path, tar_filename))
    rel
  end
end
