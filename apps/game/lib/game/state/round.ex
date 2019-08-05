defmodule GameApp.Round do
  @moduledoc """
  GameApp.Round defines a struct that encapsulates Round state as well as
  functions that update the round state.
  """

  alias __MODULE__

  defstruct [
    number: nil,
    prompt: nil,
    winner: nil,
    reactions: %{}
  ]

  @type player :: %{id: String.t()}

  @type t :: %__MODULE__{
    number: integer(),
    prompt: String.t() | nil,
    winner: player() | nil,
    reactions: map()
  }

  @doc """
  Creates a round for the given round number.

  ## Examples

      iex> GameApp.Round.create(1)
      %GameApp.Round{
        number: 1,
        winner: nil,
        reactions: %{}
      }

  """
  @spec create(integer()) :: Round.t()
  def create(number) do
    %__MODULE__{number: number}
  end

  @doc """
  Sets the prompt for a round.

  ## Examples

      iex> r = GameApp.Round.create(1)
      iex> GameApp.Round.set_prompt(r, "Wat")
      %GameApp.Round{
        number: 1,
        prompt: "Wat",
        winner: nil,
        reactions: %{}
      }

  """
  @spec set_prompt(Round.t(), String.t()) :: Round.t()
  def set_prompt(round, prompt) do
    Map.put(round, :prompt, prompt)
  end

  @doc """
  Sets the reaction for a player in a round.

  ## Examples

      iex> r = GameApp.Round.create(1)
      iex> GameApp.Round.set_reaction(r, "Gamer", "OMG!")
      %GameApp.Round{
        number: 1,
        winner: nil,
        reactions: %{
          "Gamer" => "OMG!"
        }
      }

  """
  @spec set_reaction(Round.t(), String.t(), String.t()) :: Round.t()
  def set_reaction(%Round{reactions: reactions} = round, id, reaction) do
    Map.put(round, :reactions, Map.put(reactions, id, reaction))
  end

  @doc """
  Removes the reaction for a player in a round.

  ## Examples

      iex> r = GameApp.Round.create(1)
      iex> r = GameApp.Round.set_reaction(r, "Gamer", "OMG!")
      iex> GameApp.Round.remove_reaction(r, "Gamer")
      %GameApp.Round{
        number: 1,
        winner: nil,
        reactions: %{}
      }

  """
  @spec remove_reaction(Round.t(), String.t()) :: Round.t()
  def remove_reaction(%Round{reactions: reactions} = round, id) do
    Map.put(round, :reactions, Map.delete(reactions, id))
  end

  @doc """
  Sets the winner for a round.

  ## Examples

      iex> r = GameApp.Round.create(1)
      iex> GameApp.Round.set_winner(r, %{id: "Gamer"})
      %GameApp.Round{
        number: 1,
        winner: %{id: "Gamer"},
        reactions: %{}
      }

  """
  @spec set_winner(Round.t(), player()) :: Round.t()
  def set_winner(round, winner) do
    Map.put(round, :winner, winner)
  end
end
