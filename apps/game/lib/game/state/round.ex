defmodule GameApp.Round do
  alias __MODULE__

  defstruct [
    number: nil,
    winner: nil,
    reactions: %{}
  ]

  def create(number) do
    %__MODULE__{number: number}
  end

  def set_reaction(%Round{reactions: reactions} = round, id, reaction) do
    Map.put(round, :reactions, Map.put(reactions, id, reaction))
  end

  def remove_reaction(%Round{reactions: reactions} = round, id) do
    Map.put(round, :reactions, Map.delete(reactions, id))
  end

  def set_winner(round, winner) do
    Map.put(round, :winner, winner)
  end
end
