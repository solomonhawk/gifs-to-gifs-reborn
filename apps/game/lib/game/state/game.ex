defmodule GameApp.Game do
  @moduledoc """
  GameApp.Game defines a struct that encapsulates Game state as well as many
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

      iex> GameApp.Game.create("ABCD", GameApp.Player.create("1", "Gamer"))
      %GameApp.Game{
        shortcode: "ABCD",
        creator: %GameApp.Player{id: "1", name: "Gamer"},
        players: %{"1" => %GameApp.Player{id: "1", name: "Gamer"}},
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
  Adds a player to a game.

  Returns `%Game{}`.

  ## Examples

      iex> g = GameApp.Game.create("ABCD", GameApp.Player.create("1", "Gamer"))
      iex> GameApp.Game.player_join(g, GameApp.Player.create("2", "Gamer2"))
      %GameApp.Game{
        shortcode: "ABCD",
        creator: %GameApp.Player{id: "1", name: "Gamer"},
        players: %{
          "1" => %GameApp.Player{id: "1", name: "Gamer"},
          "2" => %GameApp.Player{id: "2", name: "Gamer2"}
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

      iex> p1 = GameApp.Player.create("1", "Gamer")
      iex> p2 = GameApp.Player.create("2", "Gamer2")
      iex> g = GameApp.Game.create("ABCD", p1)
      iex> g = GameApp.Game.player_join(g, p2)
      iex> GameApp.Game.player_leave(g, p2)
      %GameApp.Game{
        shortcode: "ABCD",
        creator: %GameApp.Player{id: "1", name: "Gamer"},
        players: %{"1" => %GameApp.Player{id: "1", name: "Gamer"}},
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

      iex> g = GameApp.Game.create("ABCD", GameApp.Player.create("1", "Gamer"))
      iex> GameApp.Game.start_game(g)
      %GameApp.Game{
        shortcode: "ABCD",
        phase: :game_start,
        creator: %GameApp.Player{id: "1", name: "Gamer"},
        players: %{"1" => %GameApp.Player{id: "1", name: "Gamer"}},
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

      iex> g = GameApp.Game.create("ABCD", GameApp.Player.create("1", "Gamer"))
      iex> GameApp.Game.start_game(g)
      %GameApp.Game{
        shortcode: "ABCD",
        phase: :game_start,
        creator: %GameApp.Player{id: "1", name: "Gamer"},
        players: %{"1" => %GameApp.Player{id: "1", name: "Gamer"}},
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

  @spec start_prompt_selection(Game.t()) :: Game.t()
  def start_prompt_selection(%Game{phase: :round_start} = game) do
    game |> set_phase(:prompt_selection)
  end

  @spec select_prompt(Game.t(), String.t()) :: Game.t()
  def select_prompt(%Game{phase: :prompt_selection, rounds: rounds} = game, prompt) do
    game
    |> set_phase(:reaction_selection)
    |> update_round(Round.set_prompt(hd(rounds), prompt))
  end

  @spec select_reaction(Game.t(), Player.t(), String.t()) :: Game.t()
  def select_reaction(%Game{phase: :reaction_selection, rounds: rounds} = game, player, reaction) do
    update_round(game, Round.set_reaction(hd(rounds), player.id, reaction))
  end

  @spec start_round_end(Game.t()) :: Game.t()
  def start_round_end(%Game{phase: :winner_selection} = game) do
    game |> set_phase(:round_end)
  end

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
