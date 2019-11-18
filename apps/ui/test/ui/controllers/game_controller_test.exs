defmodule GifMe.Ui.GameControllerTest do
  use GifMe.Ui.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert redirected_to(conn, 302) =~ "/games/new"
  end
end
