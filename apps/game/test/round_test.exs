defmodule RoundTest do
  use ExUnit.Case, async: true
  alias GameApp.{Player, Round}

  doctest GameApp.Round, import: true

  @player Player.create("1", "Gamer")

  setup do
    [round: Round.create(1)]
  end

  test "create/1", %{round: round} do
    assert round.number == 1
  end
end
