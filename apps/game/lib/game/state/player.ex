defmodule GameApp.Player do
  @moduledoc """
  A player in the game.
  """

  alias __MODULE__, as: Player

  @derive Jason.Encoder
  @enforce_keys [:id, :name]
  defstruct id: nil,
            name: nil

  @type t() :: %Player{
          id: String.t(),
          name: String.t()
        }

  @doc """
  Creates a player.
  """
  @spec create(String.t(), String.t()) :: Player.t()
  def create(id, name) do
    %Player{id: id, name: name}
  end
end
