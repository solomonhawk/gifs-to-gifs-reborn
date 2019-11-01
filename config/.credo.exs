%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["apps/"],
        excluded: [
          ~r"/_build/",
          ~r"/deps/",
          ~r/node_modules/
        ]
      },
      checks: [
        {Credo.Check.Refactor.MapInto, false},
        {Credo.Check.Warning.LazyLogging, false}
      ]
    }
  ]
}
