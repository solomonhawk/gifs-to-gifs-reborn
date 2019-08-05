defmodule GameApp.Game do
  @moduledoc """
  `GameApp.Game` defines a struct that encapsulates game state as well as many
  functions that advance the game state based on actions that players can take.
  """

  alias __MODULE__, as: Game
  alias GameApp.{Player, Round}

  defstruct shortcode: nil,
            round_number: nil,
            rounds: [],
            players: %{},
            scores: %{},
            phase: :lobby,
            winner: nil,
            creator: nil,
            funmaster: nil,
            funmaster_order: []

  @type game_state ::
          :lobby
          | :game_start
          | :round_start
          | :prompt_selection
          | :reaction_selection
          | :winner_selection
          | :round_end
          | :game_end

  @type t() :: %Game{
          shortcode: String.t(),
          round_number: integer() | nil,
          rounds: list(Round.t()),
          players: %{optional(String.t()) => Player.t()},
          scores: %{optional(String.t()) => integer()},
          phase: game_state,
          winner: Player.t() | nil,
          creator: Player.t(),
          funmaster: Player.t() | nil,
          funmaster_order: list(String.t())
        }

  @doc """
  Creates a game.

  Returns `%Game{}`.

  ## Examples

      iex> Game.create("ABCD", Player.create("1", "Gamer"))
      %Game{
        shortcode: "ABCD",
        creator: %Player{id: "1", name: "Gamer"},
        players: %{"1" => %Player{id: "1", name: "Gamer"}},
        scores: %{"1" => 0}
      }

  """
  @spec create(String.t(), Player.t()) :: Game.t()
  def create(shortcode, %Player{id: id} = creator) do
    %Game{
      shortcode: shortcode,
      creator: creator,
      players: Map.new([{id, creator}]),
      scores: Map.new([{id, 0}])
    }
  end

  @doc """
  Returns a summary of the game state.

  ## Examples

      iex> g = Game.create("ABCD", Player.create("1", "Gamer"))
      iex> Game.summary(g)
      %{
        creator: %Player{id: "1", name: "Gamer"},
        funmaster: nil,
        phase: :lobby,
        players: %{"1" => %Player{id: "1", name: "Gamer"}},
        prompt: nil,
        reactions: nil,
        round_number: nil,
        scores: %{"1" => 0},
        shortcode: "ABCD",
        winner: nil
      }

  """
  @spec summary(Game.t()) :: map()
  @spec summary(Game.t(), map()) :: map()
  def summary(%Game{rounds: []} = game), do: summary(game, %{})

  def summary(%Game{rounds: rounds} = game), do: summary(game, hd(rounds))

  defp summary(%Game{} = game, round) when is_map(round) do
    %{
      shortcode: game.shortcode,
      round_number: game.round_number,
      players: game.players,
      scores: game.scores,
      phase: game.phase,
      winner: game.winner,
      creator: game.creator,
      funmaster: game.funmaster,
      prompt: Map.get(round, :prompt),
      reactions: Map.get(round, :reactions)
    }
  end

  @doc """
  Adds a player to a game.

  Returns `%Game{}`.

  ## Examples

      iex> g = Game.create("ABCD", Player.create("1", "Gamer"))
      iex> Game.player_join(g, Player.create("2", "Gamer2"))
      %Game{
        shortcode: "ABCD",
        creator: %Player{id: "1", name: "Gamer"},
        players: %{
          "1" => %Player{id: "1", name: "Gamer"},
          "2" => %Player{id: "2", name: "Gamer2"}
        },
        scores: %{"1" => 0, "2" => 0}
      }

  """
  @spec player_join(Game.t(), Player.t()) :: Game.t()
  def player_join(%Game{players: players, scores: scores} = game, %Player{id: id} = player) do
    game
    |> Map.put(:players, Map.put(players, id, player))
    |> set_player_score(player, scores[player.id])
  end

  @doc """
  Removes a player from a game.

  Returns `%Game{}`.

  ## Examples

      iex> p1 = Player.create("1", "Gamer")
      iex> p2 = Player.create("2", "Gamer2")
      iex> g = Game.create("ABCD", p1)
      iex> g = Game.player_join(g, p2)
      iex> Game.player_leave(g, p2)
      %Game{
        shortcode: "ABCD",
        creator: %Player{id: "1", name: "Gamer"},
        players: %{"1" => %Player{id: "1", name: "Gamer"}},
        scores: %{"1" => 0, "2" => 0}
      }

  """
  @spec player_leave(Game.t(), Player.t()) :: Game.t()
  def player_leave(%Game{funmaster: %{id: funmaster_id}} = game, %Player{id: id} = player)
      when id == funmaster_id do
    game
    |> remove_player(player)
    |> set_funmaster_and_order()
  end

  def player_leave(%Game{} = game, player) do
    game |> remove_player(player)
  end

  @doc """
  Starts a game.

  Returns `%Game{}`.

  ## Examples

      iex> g = Game.create("ABCD", Player.create("1", "Gamer"))
      iex> Game.start_game(g)
      %Game{
        shortcode: "ABCD",
        phase: :game_start,
        creator: %Player{id: "1", name: "Gamer"},
        players: %{"1" => %Player{id: "1", name: "Gamer"}},
        scores: %{"1" => 0}
      }

  """
  @spec start_game(Game.t()) :: Game.t()
  def start_game(%Game{phase: :lobby} = game) do
    game |> set_phase(:game_start)
  end

  @doc """
  Starts a round.

  Returns `%Game{}`.

  ## Examples

      iex> g = Game.create("ABCD", Player.create("1", "Gamer"))
      iex> Game.start_game(g)
      %Game{
        shortcode: "ABCD",
        phase: :game_start,
        creator: %Player{id: "1", name: "Gamer"},
        players: %{"1" => %Player{id: "1", name: "Gamer"}},
        scores: %{"1" => 0}
      }

  """
  @spec start_round(Game.t()) :: Game.t()
  def start_round(%Game{phase: :game_start} = game) do
    game
    |> set_phase(:round_start)
    |> set_round(1)
    |> set_funmaster_and_order()
  end

  def start_round(%Game{phase: :round_end, round_number: round_number} = game) do
    game
    |> set_phase(:round_start)
    |> set_round(round_number + 1)
    |> set_funmaster()
  end

  @doc """
  Starts prompt selection for the current round.
  """
  @spec start_prompt_selection(Game.t()) :: Game.t()
  def start_prompt_selection(%Game{phase: :round_start} = game) do
    game |> set_phase(:prompt_selection)
  end

  @doc """
  Assigns a prompt to the current round.
  """
  @spec select_prompt(Game.t(), String.t()) :: Game.t()
  def select_prompt(%Game{phase: :prompt_selection, rounds: rounds} = game, prompt) do
    game
    |> set_phase(:reaction_selection)
    |> update_round(Round.set_prompt(hd(rounds), prompt))
  end

  @doc """
  Adds a reaction in the current round for the given player.
  """
  @spec select_reaction(Game.t(), Player.t(), String.t()) :: Game.t()
  def select_reaction(%Game{phase: :reaction_selection, rounds: rounds} = game, player, reaction) do
    update_round(game, Round.set_reaction(hd(rounds), player.id, reaction))
  end

  @doc """
  Starts prompt selection for the current round.
  """
  @spec select_round_winner(Game.t(), Player.t()) :: Game.t()
  def select_round_winner(%Game{phase: :winner_selection, rounds: rounds} = game, player) do
    game
    |> update_round(Round.set_winner(hd(rounds), player))
    |> set_phase(:round_end)
  end

  # private

  @spec set_round(Game.t(), integer()) :: Game.t()
  defp set_round(%Game{rounds: rounds} = game, round_number) do
    Map.merge(game, %{
      round_number: round_number,
      rounds: [Round.create(round_number)] ++ rounds
    })
  end

  @spec set_phase(Game.t(), game_state()) :: Game.t()
  defp set_phase(game, phase) do
    Map.put(game, :phase, phase)
  end

  # defp set_winner(game, winner) do
  #   Map.put(game, :winner, winner)
  # end

  @spec set_player_score(%Game{}, map(), integer() | nil) :: %Game{}
  defp set_player_score(game, player, nil) do
    Map.put(game, :scores, Map.put(game.scores, player.id, 0))
  end

  defp set_player_score(game, player, score) do
    Map.put(game, :scores, Map.put(game.scores, player.id, score))
  end

  @spec set_funmaster_and_order(%Game{}) :: %Game{}
  defp set_funmaster_and_order(%Game{players: players} = game) when players == %{} do
    game
    |> Map.put(:funmaster, nil)
    |> Map.put(:funmaster_order, [])
  end

  defp set_funmaster_and_order(%Game{players: players} = game) do
    game
    |> Map.put(:funmaster_order, generate_funmaster_order(players))
    |> set_funmaster()
  end

  @spec set_funmaster(Game.t()) :: Game.t()
  defp set_funmaster(
         %Game{players: players, funmaster_order: order, round_number: round_number} = game
       ) do
    Map.put(game, :funmaster, funmaster_for_round(order, players, round_number))
  end

  @spec remove_player(Game.t(), Player.t()) :: Game.t()
  defp remove_player(%Game{players: players} = game, %Player{id: id} = player) do
    game
    |> Map.put(:players, Map.delete(players, id))
    |> remove_reaction(player)
  end

  @spec remove_reaction(Game.t(), Player.t()) :: Game.t()
  defp remove_reaction(%Game{rounds: []} = game, _player), do: game

  defp remove_reaction(%Game{rounds: [round | rounds]} = game, %Player{id: id}) do
    Map.put(game, :rounds, [Round.remove_reaction(round, id)] ++ rounds)
  end

  @spec update_round(Game.t(), Round.t()) :: Game.t()
  defp update_round(%Game{rounds: [_round | rounds]} = game, new_round) do
    Map.put(game, :rounds, [new_round] ++ rounds)
  end

  @spec funmaster_for_round([String.t()], map(), integer()) :: Player.t()
  defp funmaster_for_round(funmaster_order, players, round_number) do
    funmaster_order
    |> Stream.cycle()
    |> Enum.take(round_number)
    |> List.last()
    |> (&Map.get(players, &1)).()
  end

  @spec generate_funmaster_order(map()) :: [String.t()] | []
  defp generate_funmaster_order(players) do
    :random.seed(:os.timestamp())

    players
    |> Map.values()
    |> Enum.shuffle()
    |> Enum.map(& &1.id)
  end
end
