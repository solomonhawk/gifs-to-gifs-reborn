defmodule GameApp.Round do
  @moduledoc """
  `GameApp.Round` defines a struct that encapsulates Round state as well as
  functions that update the round state.
  """

  alias __MODULE__, as: Round
  alias GameApp.Player

  @enforce_keys [:number]
  defstruct number: nil,
            prompt: nil,
            winner: nil,
            reactions: %{}

  @type t :: %Round{
          number: integer(),
          prompt: String.t() | nil,
          winner: Player.t() | nil,
          reactions: map()
        }

  @doc """
  Creates a round for the given round number.

  ## Examples

      iex> Round.create(1)
      %Round{
        number: 1,
        winner: nil,
        reactions: %{}
      }

  """
  @spec create(integer()) :: Round.t()
  def create(number) do
    %Round{number: number}
  end

  @doc """
  Sets the prompt for a round.

  ## Examples

      iex> r = Round.create(1)
      iex> Round.set_prompt(r, "Wat")
      %Round{
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

      iex> r = Round.create(1)
      iex> Round.set_reaction(r, Player.create("1", "Gamer"), "OMG!")
      %Round{
        number: 1,
        winner: nil,
        reactions: %{
          "1" => "OMG!"
        }
      }

  """
  @spec set_reaction(Round.t(), Player.t(), String.t()) :: Round.t()
  def set_reaction(%Round{reactions: reactions} = round, %Player{id: id}, reaction) do
    Map.put(round, :reactions, Map.put(reactions, id, reaction))
  end

  @doc """
  Removes the reaction for a player in a round.

  ## Examples

      iex> r = Round.create(1)
      iex> p = Player.create("1", "Gamer")
      iex> r = Round.set_reaction(r, p, "OMG!")
      iex> Round.remove_reaction(r, p)
      %Round{
        number: 1,
        winner: nil,
        reactions: %{}
      }

  """
  @spec remove_reaction(Round.t(), Player.t()) :: Round.t()
  def remove_reaction(%Round{reactions: reactions} = round, %Player{id: id}) do
    Map.put(round, :reactions, Map.delete(reactions, id))
  end

  @doc """
  Sets the winner for a round.

  ## Examples

      iex> r = Round.create(1)
      iex> Round.set_winner(r, Player.create("1", "Gamer"))
      %Round{
        number: 1,
        winner: %Player{id: "1", name: "Gamer"},
        reactions: %{}
      }

  """
  @spec set_winner(Round.t(), Player.t()) :: Round.t()
  def set_winner(round, winner) do
    Map.put(round, :winner, winner)
  end
end
