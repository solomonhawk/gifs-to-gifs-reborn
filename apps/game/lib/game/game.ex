defmodule Game do
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

  def create(shortcode, %{id: id} = creator) do
    %__MODULE__{
      shortcode: shortcode,
      creator: creator,
      players: Map.new([{id, creator}]),
      scores: Map.new([{id, 0}])
    }
  end

  def player_join(%Game{players: players, scores: scores} = game, %{id: id} = player) do
    Map.merge(game, %{
      players: Map.put(players, id, player),
      scores: Map.put(scores, id, 0)
    })
  end

  def player_leave(%Game{players: players} = game, %{id: id}) do
    Map.merge(game, %{ players: Map.delete(players, id) }) # TODO: handle funmaster leaving
  end

  def start_game(%Game{phase: :lobby, players: players} = game) do
    funmaster_order = generate_funmaster_order(players)

    Map.merge(game, %{
      phase: :game_start,
      round_number: 1,
      rounds: [Round.create(1)],
      funmaster_order: funmaster_order,
      funmaster: funmaster_for_round(funmaster_order, players, 1)
    })
  end

  def start_round(%Game{phase: phase} = game) when phase in [:game_start, :round_end] do
    Map.merge(game, %{ phase: :round_start })
  end

  def start_prompt_selection(%Game{phase: :round_start} = game) do
    Map.put(game, :phase, :prompt_selection)
  end

  # private

  defp funmaster_for_round(funmaster_order, players, round_number) do
    Stream.cycle(funmaster_order)
    |> Enum.take(round_number)
    |> List.last
    |> (&(Map.get(players, &1))).()
  end

  defp generate_funmaster_order(players) do
    :random.seed(:os.timestamp)
    Map.values(players) |> Enum.shuffle() |> Enum.map(&(&1.id))
  end
end
