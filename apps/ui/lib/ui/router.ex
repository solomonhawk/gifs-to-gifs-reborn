defmodule GifMe.Ui.Router do
  use GifMe.Ui, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth do
    plug GifMe.Ui.AuthPipeline
    plug GifMe.Ui.CurrentUser
  end

  pipeline :protected do
    plug Guardian.Plug.EnsureAuthenticated
  end

  pipeline :protected_admin do
    plug GifMe.Ui.AdminPipeline
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", GifMe.Ui do
    pipe_through [:browser, :auth]

    # TODO(shawk): landing page
    get "/", Redirector, to: "/sessions/new"

    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete], singleton: true
  end

  scope "/", GifMe.Ui do
    pipe_through [:browser, :auth, :protected]

    get "/", Redirector, to: "/games/new"

    post "/join", GameController, :join, as: :join

    resources "/games", GameController, only: [:new, :create, :show]
    resources "/users", UserController, except: [:new, :create]
  end

  scope "/admin", GifMe.Ui do
    pipe_through [:browser, :auth, :protected, :protected_admin]

    resources "/prompts", PromptController
  end
end
