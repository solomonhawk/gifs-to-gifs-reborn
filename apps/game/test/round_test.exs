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

  test "set_prompt/2", %{round: round} do
    round = Round.set_prompt(round, "Wat")

    assert round.prompt == "Wat"
  end

  test "set_reaction/3", %{round: round} do
    round = Round.set_reaction(round, @player, "OMG!")

    assert Map.get(round.reactions, @player.id) == "OMG!"
  end

  test "remove_reaction/2", %{round: round} do
    round =
      round
      |> Round.set_reaction(@player, "OMG!")
      |> Round.remove_reaction(@player)

    assert Map.get(round.reactions, @player.id) == nil
  end

  test "set_winner/2", %{round: round} do
    round = Round.set_winner(round, @player)

    assert round.winner == @player
  end
end
