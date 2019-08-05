defmodule Ui.Router do
  use Ui, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_current_player
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Ui do
    pipe_through :browser

    get "/", GameController, :new
    post "/join", GameController, :join, as: :join

    resources "/games", GameController, only: [:new, :create, :show]

    resources "/sessions", SessionController,
      only: [:new, :create, :delete],
      singleton: true
  end

  defp assign_current_player(conn, _) do
    assign(conn, :current_player, get_session(conn, :current_player))
  end
end
