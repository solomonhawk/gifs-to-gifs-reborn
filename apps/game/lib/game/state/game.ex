defmodule GameApp.Game do
  @moduledoc """
  GameApp.Game defines a struct that encapsulates Game state as well as many
  functions that advance the game state based on actions that players can take.
  """

  alias __MODULE__
  alias GameApp.Round

  @type shortcode :: String.t()
  @type player :: %{id: String.t()}
  @type game :: %Game{}
  @type prompt :: String.t()
  @type reaction :: String.t()
  @type round :: %Round{}

  @type game_state ::
    :lobby |              # join/leave
    :game_start |         # pre-game summary
    :round_start |        # pre-round summary (scores, round funmaster)
    :prompt_selection |   # funmaster selects prompt
    :reaction_selection | # players select reactions
    :winner_selection |   # funmaster chooses winner(s)
    :round_end |          # post-round summary
    :game_end             # post-game summary

  defstruct [
    shortcode: nil,
    round_number: nil,
    rounds: [],
    players: %{},
    scores: %{},
    phase: :lobby,
    winner: nil,
    creator: nil,
    funmaster: nil,
    funmaster_order: []
  ]

  @doc """
  Creates a game.

  Returns `%Game{}`.

  ## Examples

      iex> GameApp.Game.create("ABCD", %{id: "Gamer"})
      %GameApp.Game{
        shortcode: "ABCD",
        creator: %{id: "Gamer"},
        players: %{"Gamer" => %{id: "Gamer"}},
        scores: %{"Gamer" => 0}
      }

  """
  @spec create(shortcode(), player()) :: game()
  def create(shortcode, %{id: id} = creator) do
    %__MODULE__{
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

      iex> g = GameApp.Game.create("ABCD", %{id: "Gamer"})
      iex> GameApp.Game.player_join(g, %{id: "Gamer2"})
      %GameApp.Game{
        shortcode: "ABCD",
        creator: %{id: "Gamer"},
        players: %{"Gamer" => %{id: "Gamer"}, "Gamer2" => %{id: "Gamer2"}},
        scores: %{"Gamer" => 0, "Gamer2" => 0}
      }

  """
  @spec player_join(game(), player()) :: game()
  def player_join(%Game{players: players, scores: scores} = game, %{id: id} = player) do
    game
    |> Map.put(:players, Map.put(players, id, player))
    |> set_player_score(player, scores[player.id])
  end

  @doc """
  Removes a player from a game.

  Returns `%Game{}`.

  ## Examples

      iex> g = GameApp.Game.create("ABCD", %{id: "Gamer"})
      iex> g = GameApp.Game.player_join(g, %{id: "Gamer2"})
      iex> GameApp.Game.player_leave(g, %{id: "Gamer2"})
      %GameApp.Game{
        shortcode: "ABCD",
        creator: %{id: "Gamer"},
        players: %{"Gamer" => %{id: "Gamer"}},
        scores: %{"Gamer" => 0, "Gamer2" => 0}
      }

  """
  @spec player_leave(game(), player()) :: game()
  def player_leave(%Game{funmaster: %{id: funmaster_id}} = game, %{id: id} = player) when id == funmaster_id do
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

      iex> g = GameApp.Game.create("ABCD", %{id: "Gamer"})
      iex> GameApp.Game.start_game(g)
      %GameApp.Game{
        shortcode: "ABCD",
        phase: :game_start,
        creator: %{id: "Gamer"},
        players: %{"Gamer" => %{id: "Gamer"}},
        scores: %{"Gamer" => 0}
      }

  """
  @spec start_game(game()) :: game()
  def start_game(%Game{phase: :lobby} = game) do
    game |> set_phase(:game_start)
  end

  @spec start_round(game()) :: game()
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

  @spec start_prompt_selection(game()) :: game()
  def start_prompt_selection(%Game{phase: :round_start} = game) do
    game |> set_phase(:prompt_selection)
  end

  @spec select_prompt(game(), prompt()) :: game()
  def select_prompt(%Game{phase: :prompt_selection} = game, prompt) do
    game
    |> set_phase(:reaction_selection)
    |> Map.put(:prompt, prompt)
  end

  @spec select_reaction(game(), player(), reaction()) :: game()
  def select_reaction(%Game{phase: :reaction_selection, rounds: rounds} = game, player, reaction) do
    update_round(game, Round.set_reaction(hd(rounds), player.id, reaction))
  end

  @spec start_round_end(game()) :: game()
  def start_round_end(%Game{phase: :winner_selection} = game) do
    game |> set_phase(:round_end)
  end

  @spec select_round_winner(game(), player()) :: game()
  def select_round_winner(%Game{phase: :winner_selection, rounds: rounds} = game, player) do
    game
    |> update_round(Round.set_winner(hd(rounds), player))
    |> set_phase(:round_end)
  end

  # private

  @spec set_round(game(), integer()) :: game()
  defp set_round(%Game{rounds: rounds} = game, round_number) do
    Map.merge(game, %{
      round_number: round_number,
      rounds: [Round.create(round_number)] ++ rounds
    })
  end

  @spec set_phase(game(), game_state()) :: game()
  defp set_phase(game, phase) do
    Map.put(game, :phase, phase)
  end

  # defp set_winner(game, winner) do
  #   Map.put(game, :winner, winner)
  # end

  @spec set_player_score(%Game{}, struct(), integer() | nil) :: %Game{}
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

  @spec set_funmaster(game()) :: game()
  defp set_funmaster(%Game{players: players, funmaster_order: funmaster_order, round_number: round_number} = game) do
    Map.put(game, :funmaster, funmaster_for_round(funmaster_order, players, round_number))
  end

  @spec remove_player(game(), player()) :: game()
  defp remove_player(%Game{players: players} = game, %{id: id} = player) do
    game
    |> Map.put(:players, Map.delete(players, id))
    |> remove_reaction(player)
  end

  @spec remove_reaction(game(), player()) :: game()
  defp remove_reaction(%Game{rounds: []} = game, _player), do: game
  defp remove_reaction(%Game{rounds: [round | rounds]} = game, %{id: id}) do
    Map.put(game, :rounds, [Round.remove_reaction(round, id)] ++ rounds)
  end

  @spec update_round(game(), round()) :: game()
  defp update_round(%Game{rounds: [_round | rounds]} = game, new_round) do
    Map.put(game, :rounds, [new_round] ++ rounds)
  end

  @spec funmaster_for_round([String.t()], [player()], integer()) :: player()
  defp funmaster_for_round(funmaster_order, players, round_number) do
    funmaster_order
    |> Stream.cycle()
    |> Enum.take(round_number)
    |> List.last
    |> (&(Map.get(players, &1))).()
  end

  @spec generate_funmaster_order([player()]) :: [String.t()] | []
  defp generate_funmaster_order(players) do
    :random.seed(:os.timestamp)

    players
    |> Map.values()
    |> Enum.shuffle()
    |> Enum.map(&(&1.id))
  end
end
