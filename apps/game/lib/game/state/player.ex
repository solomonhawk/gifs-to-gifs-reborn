defmodule GameApp.Player do
  alias __MODULE__, as: Player

  @enforce_keys [:id, :name]
  defstruct id: nil,
            name: nil

  @type t() :: %Player{
          id: String.t(),
          name: String.t()
        }

  def create(id, name) do
    %Player{id: id, name: name}
  end
end
