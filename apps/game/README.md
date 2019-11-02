# Game

The Game app provides an OTP Application that manages Game Servers that implement the Gifs2Gifs game logic.

## Usage

**TIP**: use `:observer.start()` to inspect the supervisor tree

1. Start the interactive repl

```elixir
$ iex -S mix
```

2. Create a Game Server, providing a shortcode and player (only id required for now)

```elixir
$ iex> GifMe.Game.ServerSupervisor.start_game("ABCD", %GifMe.Game.Player{ name: "fatal1ty", id: "Gamer" })
```

3. Get a summary of the game state (shortcode required to locate correct game server process to message)

```elixir
$ iex> GifMe.Game.Server.summary("ABCD")

%{
  creator: %GifMe.Game.Player{id: "gamer", name: "fatal1ity"},
  funmaster: nil,
  phase: :lobby,
  players: %{"gamer" => %GifMe.Game.Player{id: "gamer", name: "fatal1ity"}},
  prompt: nil,
  reactions: nil,
  round_number: nil,
  scores: %{"gamer" => 0},
  shortcode: "abcd",
  winner: nil
}
```

4. Join another player to the game

```elixir
$ iex> GifMe.Game.Server.join("ABCD", %GifMe.Game.Player{ id: "Noob", name: "dylan" })
```

5. Remove a player from the game

```elixir
$ iex> GifMe.Game.Server.leave("ABCD", %GifMe.Game.Player{ id: "Noob", name: "dylan"})
```

6. Start the game

```elixir
$ iex> GifMe.Game.Server.start_game("ABCD")
```

7. Start the next round

```elixir
$ iex> GifMe.Game.Server.start_round("ABCD")
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
