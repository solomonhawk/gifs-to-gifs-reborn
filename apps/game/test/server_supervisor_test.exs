defmodule ServerSupervisorTest do
  use ExUnit.Case, async: false

  alias GameApp.{ServerSupervisor, Player, Config}

  setup do
    start_supervised!(ServerSupervisor)
    :ok
  end

  test "is started by default" do
    assert %{active: 0, specs: 0, supervisors: 0, workers: 0} =
             DynamicSupervisor.count_children(ServerSupervisor)
  end

  test "can start game server worker children processes" do
    assert {:ok, _} =
             ServerSupervisor.start_game("TEST", Player.create("1", "Test Player"), %Config{})
  end

  test "can stop a game server worker child process cleanly" do
    {:ok, _} = ServerSupervisor.start_game("TEST", Player.create("1", "Test Player"), %Config{})

    assert :ok = ServerSupervisor.stop_game("TEST")

    assert %{active: 0, specs: 0, supervisors: 0, workers: 0} =
             DynamicSupervisor.count_children(ServerSupervisor)
  end

  test "restarts game server processes that crash" do
    {:ok, pid} = ServerSupervisor.start_game("TEST", Player.create("1", "Test Player"), %Config{})

    Process.exit(pid, :shutdown)

    assert %{active: 1, specs: 1, supervisors: 0, workers: 1} =
             DynamicSupervisor.count_children(ServerSupervisor)
  end
end
