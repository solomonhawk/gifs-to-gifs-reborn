defmodule ServerSupervisorTest do
  use ExUnit.Case, async: false

  alias GameApp.{ServerSupervisor, Player}

  @player Player.create(id: "1", name: "Test Player")

  setup do
    start_supervised!(ServerSupervisor)
    :ok
  end

  test "is started by default" do
    assert %{active: 0, specs: 0, supervisors: 0, workers: 0} =
             DynamicSupervisor.count_children(ServerSupervisor)
  end

  test "can start game server worker children processes" do
    assert {:ok, _} = ServerSupervisor.start_game("TEST", @player)
  end

  test "can stop a game server worker child process cleanly" do
    {:ok, _} = ServerSupervisor.start_game("TEST", @player)

    assert :ok = ServerSupervisor.stop_game("TEST")

    assert %{active: 0, specs: 0, supervisors: 0, workers: 0} =
             DynamicSupervisor.count_children(ServerSupervisor)
  end

  test "restarts game server processes that crash" do
    {:ok, pid} = ServerSupervisor.start_game("TEST", @player)
    ref = Process.monitor(pid)

    Process.exit(pid, :kill)

    receive do
      {:DOWN, ^ref, :process, ^pid, :killed} ->
        :timer.sleep(1)
        {:ok, pid} = ServerSupervisor.find_game("TEST")
        assert is_pid(pid)
    after
      1000 ->
        assert false
    end
  end
end
