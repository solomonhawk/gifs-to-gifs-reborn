defmodule Round do
  defstruct [
    number: nil,
    winner: nil,
    reactions: []
  ]

  def create(number) do
    %__MODULE__{
      number: number
    }
  end
end
