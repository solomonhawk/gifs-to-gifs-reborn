# GifsToGifs

This umbrella project holds a series of applications that together form a game
known as Gifs to Gifs which is a multiplayer turn-based game resembling
Cards Against Humanity or Apples to Apples but with GIFS!!!

## Docs

The `ExDoc` documentation is available [here](https://solomonhawk.github.io/gifs-to-gifs-reborn/).

## Starting Points

* [GifMe.Game.Game](https://solomonhawk.github.io/gifs-to-gifs-reborn/GifMe.Game.Game.html) - Game state and logic
* [GifMe.Game.Round](https://solomonhawk.github.io/gifs-to-gifs-reborn/GifMe.Game.Round.html) - Round state and logic
* [GifMe.Game.Server](https://solomonhawk.github.io/gifs-to-gifs-reborn/GifMe.Game.Server.html) - Game Server logic (GenServer)
* [GifMe.Game.ServerSupervisor](https://solomonhawk.github.io/gifs-to-gifs-reborn/GifMe.Game.ServerSupervisor.html) - Supervisor for Game Servers

## Set Up

1. Install mix dependencies

        mix deps.get

2. Follow the readme instructions for each of the apps

        cd apps/ui
        cat README.md

        cd apps/game
        cat README.md

## Running the app

To run the app locally you may either tell `mix` to start the phoenix server with or without an interactive shell.

1. **To start the server directly:**

        mix phx.server

    Alias: `make run`

2. **Or with an interactive shell:**

        iex -S mix phx.server

    Alias: `make iex`

3. **Running tests:**

        mix test

    Alias: `make t`

4. **Or to run tests in watch mode:**

        mix test.watch

    Alias: `make tw`

5. **For typechecking:**

        mix dialyzer

    Alias: `make types`

#### Disclaimer

Cards Against Humanity is distributed under a Creative Commons BY-NC-SA 2.0 license. That means you can use and remix the game for free, but you can't sell it without our permission. “Cards Against Humanity” and the CAH logos are trademarks of Cards Against Humanity LLC. Designed in-house.