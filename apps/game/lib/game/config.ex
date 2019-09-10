defmodule GameApp.Config do
  alias __MODULE__, as: GameConfig

  @derive Jason.Encoder
  defstruct rounds_per_player: 1,
            min_players: 3,
            game_timeout: :timer.minutes(10),
            winner_selection_timeout: :timer.seconds(5),
            round_start_timeout: :timer.seconds(5),
            round_end_timeout: :timer.seconds(10),
            reaction_selection_timeout: :timer.seconds(30)

  @type t() :: %GameConfig{
          rounds_per_player: integer(),
          min_players: integer(),
          game_timeout: integer(),
          winner_selection_timeout: integer(),
          round_start_timeout: integer(),
          round_end_timeout: integer(),
          reaction_selection_timeout: integer()
        }

  @spec create(keyword()) :: GameConfig.t()
  def create(attrs \\ []) do
    struct(GameConfig, attrs)
  end
end
