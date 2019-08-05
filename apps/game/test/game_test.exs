defmodule GameTest do
  use ExUnit.Case, async: true
  alias GameApp.{Game, Player}

  doctest GameApp.Game, import: true

  @shortcode "ABCD"
  @player Player.create("1", "Gamer")
  @player2 Player.create("2", "Gamer2")
  @player3 Player.create("3", "Gamer3")

  setup do
    [game: Game.create(@shortcode, @player)]
  end

  test "create/2", %{game: game} do
    assert game.shortcode == @shortcode
    assert game.creator == @player
    assert game.players[@player.id] == @player
    assert game.scores[@player.id] == 0
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

    test "when leaver is funmaster", %{game: game} do
      game =
        game
        |> Game.player_leave(@player)

      assert game.funmaster == nil
      assert game.funmaster_order == []
    end
  end

  test "start_game/1", %{game: game} do
    game =
      game
      |> Game.start_game()

    assert game.phase == :game_start
  end

  describe "start_round/1" do
    setup %{game: game} do
      game =
        game
        |> Game.player_join(@player2)
        |> Game.start_game()

      [game: game]
    end

    test "when phase is :game_start", %{game: game} do
      game =
        game
        |> Game.start_round()

      assert game.phase == :round_start
      assert game.round_number == 1
      assert length(game.rounds) == 1
      refute game.funmaster == nil
      assert length(game.funmaster_order) == 2
    end

    test "start_round/1 when phase is :round_end", %{game: game} do
      game =
        game
        |> Game.start_round()
        # TODO: fix this impl detail
        |> Map.put(:phase, :round_end)
        |> Game.start_round()

      assert game.phase == :round_start
      assert game.round_number == 2
      assert length(game.rounds) == 2
      refute game.funmaster == nil
    end
  end

  test "start_prompt_selection/1", %{game: game} do
    game =
      game
      |> Game.start_game()
      |> Game.start_round()
      |> Game.start_prompt_selection()

    assert game.phase == :prompt_selection
  end

  test "select_prompt/2", %{game: game} do
  end
end
