defmodule GameTest do
  use ExUnit.Case, async: true
  alias GameApp.{Round, Game, Player}
  alias GameApp.Config, as: GameConfig

  doctest GameApp.Game, import: true

  @shortcode "ABCD"
  @player1 Player.create(id: "1", name: "Gamer")
  @player2 Player.create(id: "2", name: "Gamer2")
  @player3 Player.create(id: "3", name: "Gamer3")

  setup do
    [game: Game.create(shortcode: @shortcode, creator: @player1)]
  end

  test "create/2", %{game: game} do
    assert game.shortcode == @shortcode
    assert game.creator == @player1
    assert game.players[@player1.id] == @player1
    assert game.scores[@player1.id] == 1
  end

  test "player_join/2", %{game: game} do
    game = Game.player_join(game, @player2)

    assert Kernel.map_size(game.players) == 2
    assert game.players[@player2.id] == @player2
    assert game.scores[@player2.id] == 0
  end

  describe "player_leave/2" do
    setup %{game: game} do
      game =
        game
        |> Game.player_join(@player2)
        |> Game.player_join(@player3)

      [game: game]
    end

    test "when leaver is player", %{game: game} do
      game =
        game
        |> Game.player_leave(@player2)

      assert Kernel.map_size(game.players) == 2
      assert game.scores[@player2.id] == 0
      refute Map.has_key?(game.players, @player2.id)
    end
  end

  test "start_game/1", %{game: game} do
    game = start_game_with_3_players(game)

    assert game.phase == :game_start
  end

  describe "start_round/1" do
    setup %{game: game} do
      [game: start_game_with_3_players(game)]
    end

    test "when phase is :game_start", %{game: game} do
      game =
        game
        |> Game.start_round()

      assert game.phase == :round_start
      assert game.round_number == 1
      assert length(game.rounds) == 1
      refute game.funmaster == nil
      assert length(game.funmaster_order) == 1
    end

    test "start_round/1 when phase is :round_end", %{game: game} do
      game =
        game
        |> advance_round_to_reaction_selection()
        |> advance_from_reaction_selection_and_select_winner(nil)
        |> Game.start_round()

      assert game.phase == :round_start
      assert game.round_number == 2
      assert length(game.rounds) == 2
      refute game.funmaster == nil
    end
  end

  test "start_prompt_selection/1", %{game: game} do
    game =
      start_game_with_3_players(game)
      |> Game.start_round()
      |> Game.start_prompt_selection()

    assert game.phase == :prompt_selection
  end

  describe "finalize/1" do
    test "with a distinct winner", %{game: game} do
      game =
        start_game_with_3_players(game)
        |> advance_round_to_reaction_selection()
        |> Game.select_reaction(@player1, "foo")
        |> Game.select_reaction(@player2, "bar")
        |> advance_from_reaction_selection_and_select_winner(@player1)
        |> Game.finalize()

      assert game.winners == [@player1]
    end

    test "with multiple winners", %{game: game} do
      game =
        start_game_with_3_players(game)
        # Round 1
        |> advance_round_to_reaction_selection()
        |> Game.select_reaction(@player1, "foo")
        |> Game.select_reaction(@player2, "bar")
        |> advance_from_reaction_selection_and_select_winner(@player1)

        # Round 2
        |> advance_round_to_reaction_selection()
        |> Game.select_reaction(@player3, "foo")
        |> Game.select_reaction(@player2, "bar")
        |> advance_from_reaction_selection_and_select_winner(@player2)
        |> Game.finalize()

      assert game.winners == [@player1, @player2]
    end

    test "with no winners", %{game: game} do
      game =
        start_game_with_3_players(game)
        |> Game.finalize()

      assert game.winners == []
    end
  end

  defp start_game_with_3_players(game) do
    :rand.seed(:exsplus, {1, 2, 3})

    game
    |> Game.player_join(@player2)
    |> Game.player_join(@player3)
    |> Game.start_game()
  end

  defp advance_round_to_reaction_selection(game) do
    game
    |> Game.start_round()
    |> Game.start_prompt_selection()
    |> Game.select_prompt("prompt")
  end

  defp advance_from_reaction_selection_and_select_winner(game, winner) do
    game
    |> Game.start_winner_selection()
    |> Game.select_winner(winner)
  end
end
