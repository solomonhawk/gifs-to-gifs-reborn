defmodule RoundTest do
  use ExUnit.Case, async: true
  doctest GameApp.Round

  alias GameApp.{Player, Round}

  @player Player.create("1", "Gamer")

  setup do
    [round: Round.create(1)]
  end

  test "create/1", %{round: round} do
    assert round.number == 1
  end
end
