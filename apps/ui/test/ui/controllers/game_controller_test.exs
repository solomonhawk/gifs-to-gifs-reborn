defmodule Ui.GameControllerTest do
  use Ui.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert redirected_to(conn, 302) =~ "/sessions/new"
  end
end
