defmodule Game do
  @type game_state :: :lobby | :game_start | :playing_round | :game_end

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

  def create(shortcode, creator) do
    %Game{
      shortcode: shortcode,
      creator: creator,
      players: Map.new([{creator.id, creator}])
    }
  end

  def player_join(game, player) do
    %Game{
      game |
      players: Map.put(game.players, player.id, player)
    }
  end

  def player_leave(game, player) do
    %Game{
      game |
      players: Map.delete(game.players, player.id)
    }
  end
end
