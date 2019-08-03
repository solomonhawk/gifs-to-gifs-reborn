# Game

The Game app provides an OTP Application that manages Game Servers that implement the Gifs2Gifs game logic.

## Usage

**TIP**: use `:observer.start()` to inspect the supervisor tree

1. Start the interactive repl

```elixir
$ iex -S mix
```

1. Create a Game Server, providing a shortcode and player (only id required for now)

```elixir
$ iex> Game.ServerSupervisor.start_game("ABCD", %{ id: "Gamer" })
```

2. Get a summary of the game state (shortcode required to locate correct game server process to message)

```elixir
$ iex> Game.Server.summary("ABCD")

%Game{
  creator: %{id: "Gamer"},
  funmaster: nil,
  funmaster_order: [],
  phase: :lobby,
  players: %{"Gamer" => %{id: "Gamer"}},
  round_number: nil,
  rounds: [],
  scores: %{},
  shortcode: "ABCD",
  winner: nil
}
```

3. Join another player to the game

```elixir
$ iex> Game.Server.join("ABCD", %{ id: "Noob" })
```

4. Remove a player from the game

```elixir
$ iex> Game.Server.leave("ABCD", %{ id: "Noob" })
```

5. Start the game

```elixir
$ iex> Game.Server.start_game("ABCD")
```

6. Start the next round

```elixir
$ iex> Game.Server.start_round("ABCD")
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `game` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:game, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/game](https://hexdocs.pm/game).